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

#include "prov/implementations.h"
#include "prov/providercommon.h"
#include "prov/ciphercommon.h"
#include "prov/ciphercommon_aead.h"
#include "prov/ciphercommon_gcm.h"

/*
static const PROV_GCM_HW psa_aes_gcm = {
    aes_gcm_initkey,
    ossl_gcm_setiv,
    ossl_gcm_aad_update,
    generic_aes_gcm_cipher_update,
    ossl_gcm_cipher_final,
    ossl_gcm_one_shot
};
*/

extern psa_key_id_t key_id_cnt;
static inline int get_next_key_id()
{
  return key_id_cnt++;
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

  int psa_setkey(PROV_GCM_CTX *ctx, const unsigned char *key,
                                   size_t keylen){
                                    
    psa_prov_set_key(get_next_key_id(),keylen,PSA_KEY_TYPE_AES, PSA_ALG_GCM,ctx->enc ? PSA_KEY_USAGE_ENCRYPT : PSA_KEY_USAGE_DECRYPT,key);
    psactx->aead_operation = psa_aead_operation_init();                                          \
    PSA_CRYPTO_MUTEX_UNLOCK                                                                      \
    TEST_RESULT_TS(                                                                              \
      psa_aead_encrypt_setup(&(psactx->aead_operation), psactx->key, alg),                       \
      PSA_SUCCESS);         
  }
  
static const PROV_GCM_HW psa_aes_gcm = {
    psa_setkey,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL
};
typedef struct prov_aes_gcm_ctx_st {
    PROV_GCM_CTX base;          /* must be first entry in struct */
    
    union {
        OSSL_UNION_ALIGN;
        AES_KEY ks;
    } ks;                       /* AES key schedule to use */

    /* Platform specific data */
    union {
        int dummy;
#if defined(OPENSSL_CPUID_OBJ) && defined(__s390__)
        struct {
            union {
                OSSL_UNION_ALIGN;
                S390X_KMA_PARAMS kma;
            } param;
            unsigned int fc;
            unsigned int hsflag;    /* hash subkey set flag */
            unsigned char ares[16];
            unsigned char mres[16];
            unsigned char kres[16];
            int areslen;
            int mreslen;
            int kreslen;
            int res;
        } s390x;
#endif /* defined(OPENSSL_CPUID_OBJ) && defined(__s390__) */
    } plat;
} PROV_AES_GCM_CTX;

static void *aes_gcm_newctx(void *provctx, size_t keybits)
{
    PROV_AES_GCM_CTX *ctx;

    if (!ossl_prov_is_running())
        return NULL;

    ctx = OPENSSL_zalloc(sizeof(*ctx));
    if (ctx != NULL)
        ossl_gcm_initctx(provctx, &ctx->base, keybits,
                         &psa_aes_gcm);
    return ctx;
}

static OSSL_FUNC_cipher_freectx_fn aes_gcm_freectx;
static void aes_gcm_freectx(void *vctx)
{
    PROV_AES_GCM_CTX *ctx = (PROV_AES_GCM_CTX *)vctx;

    OPENSSL_clear_free(ctx,  sizeof(*ctx));
}

/* ossl_aes128gcm_functions */
IMPLEMENT_aead_cipher(aes, gcm, GCM, AEAD_FLAGS, 128, 8, 96);
/* ossl_aes192gcm_functions */
IMPLEMENT_aead_cipher(aes, gcm, GCM, AEAD_FLAGS, 192, 8, 96);
/* ossl_aes256gcm_functions */
IMPLEMENT_aead_cipher(aes, gcm, GCM, AEAD_FLAGS, 256, 8, 96);