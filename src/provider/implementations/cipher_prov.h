/*
 * Copyright 2019-2021 The OpenSSL Project Authors. All Rights Reserved.
 *
 * Licensed under the Apache License 2.0 (the "License").  You may not use
 * this file except in compliance with the License.  You can obtain a copy
 * in the file LICENSE in the source distribution or at
 * https://www.openssl.org/source/license.html
 */

/*
 * SHA low level APIs are deprecated for public use, but still ok for
 * internal use.
 */
#include <stdint.h>
#include <stdlib.h>
#include <string.h>
#include <openssl/crypto.h>
#include <openssl/core_dispatch.h>
#include <openssl/params.h>
#include <openssl/proverr.h>
#include <openssl/core_names.h>
#include "prov/ciphercommon.h"
#include "prov/ciphercommon_aead.h"
#include "prov/implementations.h"

#include "common.h"
#include "thread_safety.h"

#define AES_BLOCK_SIZE 128
typedef struct {
  psa_aead_operation_t aead_operation; /* struct needed for hardware */
  //psa_cipher_operation_t cipher_operation;
  psa_key_id_t key; /* key id */

  unsigned int mode;          /* The mode that we are using */
  size_t keylen;
  size_t ivlen;
  size_t taglen;
  size_t tls_aad_pad_sz;
  size_t tls_aad_len;           /* TLS AAD length */
  uint64_t tls_enc_records;     /* Number of TLS records encrypted */

  unsigned int iv_state;        /* set to one of IV_STATE_XXX */
  unsigned int enc : 1;         /* Set to 1 if we are encrypting or 0 otherwise */
  unsigned int pad : 1;         /* Whether padding should be used or not */
  unsigned int key_set : 1;     /* Set if key initialised */
  unsigned int iv_gen_rand : 1; /* No IV was specified, so generate a rand IV */
  unsigned int iv_gen : 1;      /* It is OK to generate IVs */

  unsigned char iv[PSA_AEAD_NONCE_MAX_SIZE];   /* Buffer to use for IV's */
  unsigned char buf[PSA_AEAD_NONCE_MAX_SIZE];   /* Buffer of partial blocks processed via update calls */
} PSA_CIPHER_CTX;

static OSSL_FUNC_cipher_newctx_fn cipher_newctx;
static OSSL_FUNC_cipher_freectx_fn cipher_freectx;
static OSSL_FUNC_cipher_dupctx_fn cipher_dupctx;
int ossl_psa_gcm_set_ctx_params(void *vctx, const OSSL_PARAM params[]);
int ossl_psa_gcm_get_ctx_params(void *vctx, OSSL_PARAM params[]);
int ossl_psa_gcm_cipher(void *vctx,
                        unsigned char *out, size_t *outl, size_t outsize,
                        const unsigned char *in, size_t inl);
int ossl_psa_gcm_stream_update(void *vctx, unsigned char *out, size_t *outl,
                               size_t outsize, const unsigned char *in, size_t inl);
int ossl_psa_gcm_stream_final(void *vctx, unsigned char *out, size_t *outl,
                              size_t outsize);
static int psa_prov_set_key(psa_key_id_t key_id, size_t key_length,
                            psa_key_type_t type, psa_algorithm_t alg,
                            psa_key_usage_t usage_flags, const uint8_t *data, psa_key_persistence_t persistence);
extern psa_key_id_t key_id_cnt;

static inline int get_next_key_id()
{
  return key_id_cnt++;
}

static void * ossl_psa_gcm_initctx(size_t keybits)
{
  PSA_CIPHER_CTX *ctx;
  if (!ossl_prov_is_running()) {
    return NULL;
  }
  ctx = OPENSSL_zalloc(sizeof(*ctx));
  if (ctx != NULL) {
    ctx->pad = 1;
    ctx->mode = EVP_CIPH_GCM_MODE;
    ctx->taglen = UNINITIALISED_SIZET;
    ctx->tls_aad_len = UNINITIALISED_SIZET;
    ctx->ivlen = (EVP_GCM_TLS_FIXED_IV_LEN + EVP_GCM_TLS_EXPLICIT_IV_LEN);
    ctx->keylen = keybits / 8;
    ctx->key = 0;
    PSA_CRYPTO_MUTEX_LOCK
    ctx->aead_operation = psa_aead_operation_init();
    PSA_CRYPTO_MUTEX_UNLOCK
  }
  return (void *)ctx;
}

static void cipher_freectx(void *vctx)
{
  PSA_CIPHER_CTX *ctx = (PSA_CIPHER_CTX *)vctx;
  PSA_CRYPTO_MUTEX_LOCK
  if (ctx->tls_enc_records) {
    psa_destroy_key(ctx->key);
  }
  PSA_CRYPTO_MUTEX_UNLOCK
  OPENSSL_clear_free(ctx, sizeof(*ctx));
}

static void *cipher_dupctx(void *ctx)
{
  PSA_CIPHER_CTX *in = (PSA_CIPHER_CTX *)ctx;
  PSA_CIPHER_CTX *ret = ossl_prov_is_running() ? OPENSSL_malloc(sizeof(*ret)) : NULL;
  if (ret != NULL) {
    *ret = *in;
  }
  return ret;
}

# define IMPLEMENT_cipher_operation(name, keySize, mode, UCMODE, alg, keyType)                                                                                              \
                                                                                                                                                                            \
  static void * name##_##keySize##_##mode##_cipher_newctx(void *prov_ctx)                                                                                                   \
  {                                                                                                                                                                         \
    return ossl_psa_gcm_initctx(keySize);                                                                                                                                   \
  }                                                                                                                                                                         \
                                                                                                                                                                            \
  static int name##_##keySize##_##mode##_init(void *vctx, const unsigned char *key, size_t keylen,                                                                          \
                                              const unsigned char *iv, size_t ivlen,                                                                                        \
                                              const OSSL_PARAM params[], int enc)                                                                                           \
  {                                                                                                                                                                         \
    PSA_CIPHER_CTX *ctx = (PSA_CIPHER_CTX *)vctx;                                                                                                                           \
                                                                                                                                                                            \
    if (!ossl_prov_is_running()) {                                                                                                                                          \
      return OPENSSL_FAILURE;                                                                                                                                               \
    }                                                                                                                                                                       \
                                                                                                                                                                            \
    ctx->enc = enc;                                                                                                                                                         \
                                                                                                                                                                            \
    if (iv != NULL) {                                                                                                                                                       \
      if (ivlen == 0 || ivlen > sizeof(ctx->iv)) {                                                                                                                          \
        ERR_raise(ERR_LIB_PROV, PROV_R_INVALID_IV_LENGTH);                                                                                                                  \
        return OPENSSL_FAILURE;                                                                                                                                             \
      }                                                                                                                                                                     \
      ctx->ivlen = ivlen;                                                                                                                                                   \
      memcpy(ctx->iv, iv, ivlen);                                                                                                                                           \
      ctx->iv_state = IV_STATE_BUFFERED;                                                                                                                                    \
    }                                                                                                                                                                       \
                                                                                                                                                                            \
    if (key != NULL) {                                                                                                                                                      \
      if (keylen != ctx->keylen) {                                                                                                                                          \
        ERR_raise(ERR_LIB_PROV, PROV_R_INVALID_KEY_LENGTH);                                                                                                                 \
        return OPENSSL_FAILURE;                                                                                                                                             \
      }                                                                                                                                                                     \
                                                                                                                                                                            \
      if (ctx->key == 0) {                                                                                                                                                  \
        if (strncmp(key, "KEY_ID:", 7) == 0) {                                                                                                                              \
          ctx->key = key[10];                                                                                                                                               \
          ctx->key <<= 8;                                                                                                                                                   \
          ctx->key |= key[9];                                                                                                                                               \
          ctx->key <<= 8;                                                                                                                                                   \
          ctx->key |= key[8];                                                                                                                                               \
          ctx->key <<= 8;                                                                                                                                                   \
          ctx->key |= key[7];                                                                                                                                               \
        } else {                                                                                                                                                            \
          ctx->key = get_next_key_id();                                                                                                                                     \
          if (enc) {                                                                                                                                                        \
            TEST_EQUAL(psa_prov_set_key(ctx->key, keySize, keyType, alg,                                                                                                    \
                                        PSA_KEY_USAGE_ENCRYPT, (const uint8_t *) key, PSA_KEY_PERSISTENCE_VOLATILE), OPENSSL_SUCCESS, PROV_R_UNABLE_TO_INITIALISE_CIPHERS); \
          } else {                                                                                                                                                          \
            TEST_EQUAL(psa_prov_set_key(ctx->key, keySize, keyType, alg,                                                                                                    \
                                        PSA_KEY_USAGE_DECRYPT, (const uint8_t *) key, PSA_KEY_PERSISTENCE_VOLATILE), OPENSSL_SUCCESS, PROV_R_UNABLE_TO_INITIALISE_CIPHERS); \
          }                                                                                                                                                                 \
        }                                                                                                                                                                   \
        ctx->key_set = 1;                                                                                                                                                   \
      }                                                                                                                                                                     \
    }                                                                                                                                                                       \
    if (ctx->key_set) {                                                                                                                                                     \
      ctx->tls_enc_records = 0;                                                                                                                                             \
      if (enc) {                                                                                                                                                            \
        TEST_EQUAL(psa_aead_encrypt_setup(&ctx->aead_operation, ctx->key, alg), PSA_SUCCESS, PROV_R_UNABLE_TO_INITIALISE_CIPHERS);                                          \
        ctx->taglen = PSA_AEAD_TAG_LENGTH(keyType, keySize, alg);                                                                                                           \
      } else {                                                                                                                                                              \
        TEST_EQUAL(psa_aead_decrypt_setup(&ctx->aead_operation, ctx->key, alg), PSA_SUCCESS, PROV_R_UNABLE_TO_INITIALISE_CIPHERS);                                          \
      }                                                                                                                                                                     \
    }                                                                                                                                                                       \
                                                                                                                                                                            \
    return ossl_psa_gcm_set_ctx_params(ctx, params);                                                                                                                        \
  }                                                                                                                                                                         \
                                                                                                                                                                            \
  static int name##_##keySize##_##mode##_encrypt_init(void *vctx, const unsigned char *key,                                                                                 \
                                                      size_t keylen, const unsigned char *iv,                                                                               \
                                                      size_t ivlen, const OSSL_PARAM params[]){                                                                             \
    return name##_##keySize##_##mode##_init(vctx, key, keylen, iv, ivlen, params, 1);                                                                                       \
  }                                                                                                                                                                         \
                                                                                                                                                                            \
  static int name##_##keySize##_##mode##_decrypt_init(void *vctx, const unsigned char *key,                                                                                 \
                                                      size_t keylen, const unsigned char *iv,                                                                               \
                                                      size_t ivlen, const OSSL_PARAM params[]){                                                                             \
    return name##_##keySize##_##mode##_init(vctx, key, keylen, iv, ivlen, params, 0);                                                                                       \
  }                                                                                                                                                                         \
                                                                                                                                                                            \
  static int name##_##keySize##_##mode##_get_params(OSSL_PARAM params[])                                                                                                    \
  {                                                                                                                                                                         \
    return ossl_cipher_generic_get_params(params, EVP_CIPH_##UCMODE##_MODE,                                                                                                 \
                                          AEAD_FLAGS, keySize,                                                                                                              \
                                          AES_BLOCK_SIZE, PSA_AEAD_NONCE_LENGTH(keyType, alg));                                                                             \
  }                                                                                                                                                                         \
                                                                                                                                                                            \
  const OSSL_DISPATCH ossl_##name##keySize##mode##_functions[] = {                                                                                                          \
    { OSSL_FUNC_CIPHER_NEWCTX, (void (*)(void))name##_##keySize##_##mode##_cipher_newctx },                                                                                 \
    { OSSL_FUNC_CIPHER_ENCRYPT_INIT, (void (*)(void))name##_##keySize##_##mode##_encrypt_init },                                                                            \
    { OSSL_FUNC_CIPHER_DECRYPT_INIT, (void (*)(void))name##_##keySize##_##mode##_decrypt_init },                                                                            \
    { OSSL_FUNC_CIPHER_UPDATE, (void (*)(void))ossl_psa_gcm_stream_update },                                                                                                \
    { OSSL_FUNC_CIPHER_FINAL, (void (*)(void))ossl_psa_gcm_stream_final },                                                                                                  \
    { OSSL_FUNC_CIPHER_CIPHER, (void (*)(void))ossl_psa_gcm_cipher },                                                                                                       \
    { OSSL_FUNC_CIPHER_FREECTX, (void (*)(void))cipher_freectx },                                                                                                           \
    { OSSL_FUNC_CIPHER_DUPCTX, (void (*)(void))cipher_dupctx },                                                                                                             \
    { OSSL_FUNC_CIPHER_GET_PARAMS, (void (*)(void))name##_##keySize##_##mode##_get_params },                                                                                \
    { OSSL_FUNC_CIPHER_GETTABLE_PARAMS, (void (*)(void))ossl_cipher_generic_gettable_params },                                                                              \
    { OSSL_FUNC_CIPHER_GETTABLE_CTX_PARAMS, (void (*)(void))ossl_cipher_aead_gettable_ctx_params },                                                                         \
    { OSSL_FUNC_CIPHER_SETTABLE_CTX_PARAMS, (void (*)(void))ossl_cipher_aead_settable_ctx_params },                                                                         \
    { OSSL_FUNC_CIPHER_SET_CTX_PARAMS, (void (*)(void))ossl_psa_gcm_set_ctx_params },                                                                                       \
    { OSSL_FUNC_CIPHER_GET_CTX_PARAMS, (void (*)(void))ossl_psa_gcm_get_ctx_params },                                                                                       \
    { 0, NULL }                                                                                                                                                             \
  };

IMPLEMENT_cipher_operation(aes, 256, gcm, GCM, PSA_ALG_GCM, PSA_KEY_TYPE_AES)
IMPLEMENT_cipher_operation(aes, 192, gcm, GCM, PSA_ALG_GCM, PSA_KEY_TYPE_AES)
IMPLEMENT_cipher_operation(aes, 128, gcm, GCM, PSA_ALG_GCM, PSA_KEY_TYPE_AES)
//IMPLEMENT_cipher_operation(aes, 256, ccm, PSA_ALG_CCM, PSA_KEY_TYPE_AES)
/*
   ossl_aes256gcm_functions),
   ossl_aes192gcm_functions),
   ossl_aes128gcm_functions),
   ossl_aes256ccm_functions),
   ossl_aes192ccm_functions),
   ossl_aes128ccm_functions),
 */
