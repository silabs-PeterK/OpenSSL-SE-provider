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
#include <openssl/core_names.h>
#include "prov/ciphercommon.h"
#include "prov/ciphercommon_aead.h"
#include "prov/implementations.h"

#include "common.h"
#include "thread_safety.h"

typedef struct CIPHERstate_st {
  psa_aead_operation_t aead_operation;
  //psa_cipher_operation_t cipher_operation;
  psa_key_id_t key;
  size_t ivlen;
  size_t taglen;
  uint64_t tls_enc_records;

  unsigned int iv_state;        /* set to one of IV_STATE_XXX */
  unsigned int enc : 1;             /* Set to 1 if we are encrypting or 0 otherwise */

  uint8_t iv[PSA_AEAD_NONCE_MAX_SIZE];
  unsigned char buf[PSA_AEAD_NONCE_MAX_SIZE]; /* Buffer of partial blocks processed via update calls */
} psa_cipher_CTX;

static OSSL_FUNC_cipher_newctx_fn cipher_newctx;
static OSSL_FUNC_cipher_freectx_fn cipher_freectx;
static OSSL_FUNC_cipher_dupctx_fn cipher_dupctx;

extern psa_key_id_t key_id_cnt;
static inline int get_next_key_id()
{
  return key_id_cnt++;
}

static void *cipher_newctx(void *prov_ctx)
{
  psa_cipher_CTX *ctx = ossl_prov_is_running() ? OPENSSL_zalloc(sizeof(*ctx)) : NULL;
  ctx->key = 0;

  return ctx;
}

static void cipher_freectx(void *vctx)
{
  psa_cipher_CTX *ctx = (psa_cipher_CTX *)vctx;
  OPENSSL_clear_free(ctx, sizeof(*ctx));
}

static void *cipher_dupctx(void *ctx)
{
  psa_cipher_CTX *in = (psa_cipher_CTX *)ctx;
  psa_cipher_CTX *ret = ossl_prov_is_running() ? OPENSSL_malloc(sizeof(*ret)) : NULL;
  if (ret != NULL) {
    *ret = *in;
  }
  return ret;
}

static psa_status_t psa_prov_set_key(psa_key_id_t key_id, size_t key_length, psa_key_type_t type, psa_algorithm_t alg, psa_key_usage_t usage_flags, const uint8_t *data)
{
  psa_status_t status = PSA_ERROR_GENERIC_ERROR;
  psa_key_attributes_t key_attr;
  psa_key_id_t key_id_local;
  PSA_CRYPTO_MUTEX_LOCK
    key_attr = psa_key_attributes_init();
  psa_set_key_bits(&key_attr, key_length);
  psa_set_key_type(&key_attr, type);
  psa_set_key_algorithm(&key_attr, alg);
  psa_set_key_usage_flags(&key_attr, usage_flags);
  psa_set_key_id(&key_attr, key_id);
  // psa_set_key_lifetime(&key_attr,
  //                     PSA_KEY_LIFETIME_FROM_PERSISTENCE_AND_LOCATION(PSA_KEY_PERSISTENCE_DEFAULT,
  //                                                                   WRAP_KEY_LOCATION));
  PSA_CRYPTO_MUTEX_UNLOCK
  psa_destroy_key(key_id);
  TEST_RESULT_TS(psa_import_key(&key_attr, data, key_length / 8, &key_id_local), PSA_SUCCESS);
  TEST_EQUAL(key_id_local, key_id);
  return OPENSSL_SUCCESS;
}

static int d333_set_ctx_params(void *cctx, const OSSL_PARAM params[])
{
  PSA_SUCCESS;
}

static int cipher_update(void *cctx,
                         unsigned char *out, size_t *outl, size_t outsize,
                         const unsigned char *in, size_t inl)
{
  psa_cipher_CTX * psactx = (psa_cipher_CTX *) cctx;
  TEST_NOT_NULL(psactx)
  if ((in == NULL) || (inl = 0)) {
    TEST_RESULT_TS(psa_aead_abort(&(psactx->aead_operation)), PSA_SUCCESS);
    return OPENSSL_SUCCESS;
  }

  if (out == NULL) {
    TEST_RESULT_TS(psa_aead_update_ad(&(psactx->aead_operation),
                                      (const uint8_t *) in,
                                      inl), PSA_SUCCESS);
  } else {
    TEST_RESULT_TS(psa_aead_update(&(psactx->aead_operation),
                                   (const uint8_t *) in,
                                   inl,
                                   (uint8_t *) out,
                                   outsize,
                                   outl), PSA_SUCCESS);
  }
  return OPENSSL_SUCCESS;
}

static int cipher_final(void *cctx,
                        unsigned char *out, size_t *outl, size_t outsize)
{
  psa_cipher_CTX * psactx = (psa_cipher_CTX *) cctx;
  if (psactx->enc) {
    TEST_RESULT_TS(psa_aead_finish(&(psactx->aead_operation),
                                   out,
                                   outsize,
                                   outl,
                                   (uint8_t *) psactx->buf,
                                   psactx->taglen, //in
                                   &psactx->taglen), PSA_SUCCESS);
  } else {
    TEST_EQUAL(psactx->taglen, UNINITIALISED_SIZET);
  //  TEST_RESULT_TS(
   //   psa_aead_verify(&(psactx->aead_operation),
     //                 uint8_t * plaintext,
       //               size_t plaintext_size,
         //             size_t * plaintext_length,
           //           (const uint8_t *) psactx->buf,
    //                  psactx->taglen), PSA_SUCCESS);
  }

  psactx->iv_state = IV_STATE_FINISHED; /* Don't reuse the IV */
  return OPENSSL_SUCCESS;
}

# define IMPLEMENT_cipher_operation(name, keySize, mode, alg, keyType)                           \
                                                                                                 \
  static int name##_##keySize##_##mode##_set_ctx_params(void *cctx, const OSSL_PARAM params[])   \
  {                                                                                              \
    return OPENSSL_SUCCESS;                                                                      \
  }                                                                                              \
                                                                                                 \
  static int name##_##keySize##_##mode##_encrypt_init(void *cctx, const unsigned char *key,      \
                                                      size_t keylen, const unsigned char *iv,    \
                                                      size_t ivlen, const OSSL_PARAM params[]){  \
    psa_status_t status = PSA_ERROR_GENERIC_ERROR;                                               \
    psa_cipher_CTX * psactx = (psa_cipher_CTX *) cctx;                                           \
    size_t nonce_length;                                                                         \
    if (!ossl_prov_is_running()) {                                                               \
      return OPENSSL_FAILURE;                                                                    \
    }                                                                                            \
    TEST_NOT_NULL(psactx)                                                                        \
    psactx->enc = 1;                                                                             \
    psactx->taglen = PSA_AEAD_TAG_LENGTH(keyType, keySize, alg);                                 \
    if (psactx->key == 0) {                                                                      \
      TEST_NOT_NULL(key)                                                                         \
      if (strncmp(key, "KEY_ID:", 7) == 0) {                                                     \
        psactx->key = key[10];                                                                   \
        psactx->key <<= 8;                                                                       \
        psactx->key = key[9];                                                                    \
        psactx->key <<= 8;                                                                       \
        psactx->key = key[8];                                                                    \
        psactx->key <<= 8;                                                                       \
        psactx->key = key[7];                                                                    \
      }                                                                                          \
      else {                                                                                     \
        psactx->key = get_next_key_id();                                                         \
        psa_prov_set_key(psactx->key, keySize, keyType, alg, PSA_KEY_USAGE_ENCRYPT, key);        \
      }                                                                                          \
    }                                                                                            \
    PSA_CRYPTO_MUTEX_LOCK                                                                        \
    psactx->aead_operation = psa_aead_operation_init();                                          \
    PSA_CRYPTO_MUTEX_UNLOCK                                                                      \
    TEST_RESULT_TS(                                                                              \
      psa_aead_encrypt_setup(&(psactx->aead_operation), psactx->key, alg),                       \
      PSA_SUCCESS);                                                                              \
    TEST_RESULT_TS(psa_aead_generate_nonce(&(psactx->aead_operation),                            \
                                           psactx->iv,                                           \
                                           PSA_AEAD_NONCE_LENGTH(keyType, alg),                  \
                                           &psactx->ivlen),                                      \
                   PSA_SUCCESS);                                                                 \
    TEST_EQUAL(PSA_AEAD_NONCE_LENGTH(keyType, alg), psactx->ivlen)                               \
    psactx->tls_enc_records = 0;                                                                 \
    return OPENSSL_SUCCESS;                                                                      \
  }                                                                                              \
                                                                                                 \
  static int name##_##keySize##_##mode##_decrypt_init(void *cctx, const unsigned char *key,      \
                                                      size_t keylen, const unsigned char *iv,    \
                                                      size_t ivlen, const OSSL_PARAM params[]){  \
    psa_status_t status = PSA_ERROR_GENERIC_ERROR;                                               \
    if (!ossl_prov_is_running()) {                                                               \
      return OPENSSL_FAILURE;                                                                    \
    }                                                                                            \
    psa_cipher_CTX * psactx = (psa_cipher_CTX *) EVP_CIPHER_CTX_get_cipher_data(cctx);           \
    if (psactx == NULL) {                                                                        \
      psactx = OPENSSL_zalloc(sizeof(psa_cipher_CTX));                                           \
      EVP_CIPHER_CTX_set_cipher_data(cctx, (void*)psactx);                                       \
      psactx->key = 0;                                                                           \
    }                                                                                            \
                                                                                                 \
    if (psactx->key == 0) {                                                                      \
      if (key == NULL) {                                                                         \
        return OPENSSL_FAILURE;                                                                  \
      }                                                                                          \
      psactx->key = get_next_key_id();                                                           \
      d333_set_ctx_params(cctx, params);                                                         \
    }                                                                                            \
    PSA_CRYPTO_MUTEX_LOCK                                                                        \
    psactx->aead_operation = psa_aead_operation_init();                                          \
    PSA_CRYPTO_MUTEX_UNLOCK                                                                      \
    TEST_RESULT_TS(                                                                              \
      psa_aead_decrypt_setup(&(psactx->aead_operation), psactx->key, alg),                       \
      PSA_SUCCESS);                                                                              \
    return OPENSSL_SUCCESS;                                                                      \
  }                                                                                              \
                                                                                                 \
  static int name##_##keySize##_##mode##_get_params(OSSL_PARAM params[])                         \
  {                                                                                              \
    OSSL_PARAM *p = NULL;                                                                        \
    p = OSSL_PARAM_locate(params, OSSL_DIGEST_PARAM_BLOCK_SIZE);                                 \
    if (p != NULL && !OSSL_PARAM_set_size_t(p, 64)) {                                            \
      return OPENSSL_FAILURE;                                                                    \
    }                                                                                            \
    p = OSSL_PARAM_locate(params, OSSL_DIGEST_PARAM_SIZE);                                       \
    if (p != NULL && !OSSL_PARAM_set_size_t(p, 32)) {                                            \
      return OPENSSL_FAILURE;                                                                    \
    }                                                                                            \
    return OPENSSL_SUCCESS;                                                                      \
  }                                                                                              \
                                                                                                 \
  const OSSL_DISPATCH ossl_##name##keySize##mode##_functions[] = {                               \
    { OSSL_FUNC_CIPHER_NEWCTX, (void (*)(void))cipher_newctx },                                  \
    { OSSL_FUNC_CIPHER_ENCRYPT_INIT, (void (*)(void))name##_##keySize##_##mode##_encrypt_init }, \
    { OSSL_FUNC_CIPHER_DECRYPT_INIT, (void (*)(void))name##_##keySize##_##mode##_decrypt_init }, \
    { OSSL_FUNC_CIPHER_UPDATE, (void (*)(void))cipher_update },                                  \
    { OSSL_FUNC_CIPHER_FINAL, (void (*)(void))cipher_final },                                    \
    { OSSL_FUNC_CIPHER_FREECTX, (void (*)(void))cipher_freectx },                                \
    { OSSL_FUNC_CIPHER_DUPCTX, (void (*)(void))cipher_dupctx },                                  \
    { OSSL_FUNC_CIPHER_SET_CTX_PARAMS, (void (*)(void))d333_set_ctx_params },                    \
    { OSSL_FUNC_CIPHER_GET_PARAMS, (void (*)(void))name##_##keySize##_##mode##_get_params },     \
    { 0, NULL }                                                                                  \
  };

IMPLEMENT_cipher_operation(aes, 256, gcm, PSA_ALG_GCM, PSA_KEY_TYPE_AES)
IMPLEMENT_cipher_operation(aes, 256, ccm, PSA_ALG_CCM, PSA_KEY_TYPE_AES)
/*
   ossl_aes256gcm_functions),
   ossl_aes192gcm_functions),
   ossl_aes128gcm_functions),
   ossl_aes256ccm_functions),
   ossl_aes192ccm_functions),
   ossl_aes128ccm_functions),
 */
