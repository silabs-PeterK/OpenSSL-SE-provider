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
#include <openssl/crypto.h>
#include <openssl/core_dispatch.h>
#include <openssl/params.h>
#include <openssl/core_names.h>
#include "prov/digestcommon.h"
#include "prov/implementations.h"

#include "common.h"
#include "thread_safety.h"

extern  pthread_mutex_t psa_crypto_mutex;

typedef struct {
  psa_hash_operation_t operation;
} PSA_HASH_CTX;

# define IMPLEMENT_hashing_operation(name, alg)                                                                                     \
  static OSSL_FUNC_digest_newctx_fn name##_newctx;                                                                                  \
  static OSSL_FUNC_digest_freectx_fn name##_freectx;                                                                                \
  static OSSL_FUNC_digest_dupctx_fn name##_dupctx;                                                                                  \
                                                                                                                                    \
  static void *name##_newctx(void *prov_ctx)                                                                                        \
  {                                                                                                                                 \
    PSA_HASH_CTX *ctx = ossl_prov_is_running() ? OPENSSL_zalloc(sizeof(*ctx)) : NULL;                                               \
    return ctx;                                                                                                                     \
  }                                                                                                                                 \
                                                                                                                                    \
  static void name##_freectx(void *vctx)                                                                                            \
  {                                                                                                                                 \
    PSA_HASH_CTX *ctx = (PSA_HASH_CTX *)vctx;                                                                                       \
    OPENSSL_clear_free(ctx, sizeof(*ctx));                                                                                          \
  }                                                                                                                                 \
                                                                                                                                    \
  static void *name##_dupctx(void *ctx)                                                                                             \
  {                                                                                                                                 \
    PSA_HASH_CTX *in = (PSA_HASH_CTX *)ctx;                                                                                         \
    PSA_HASH_CTX *ret = ossl_prov_is_running() ? OPENSSL_malloc(sizeof(*ret)) : NULL;                                               \
    if (ret != NULL) {                                                                                                              \
      *ret = *in; }                                                                                                                 \
    return ret;                                                                                                                     \
  }                                                                                                                                 \
                                                                                                                                    \
  static int name##_Init(PSA_HASH_CTX * c, ossl_unused const OSSL_PARAM params[])                                                   \
  {                                                                                                                                 \
    if (!ossl_prov_is_running()) {                                                                                                  \
      return OPENSSL_FAILURE; }                                                                                                     \
    psa_status_t status = PSA_ERROR_GENERIC_ERROR;                                                                                  \
    PSA_CRYPTO_MUTEX_LOCK                                                                                                           \
    c->operation = psa_hash_operation_init();                                                                                       \
    status = psa_hash_setup(&c->operation, alg);                                                                                    \
    PSA_CRYPTO_MUTEX_UNLOCK                                                                                                         \
    return (status == PSA_SUCCESS);                                                                                                 \
  }                                                                                                                                 \
                                                                                                                                    \
  static int name##_Update(PSA_HASH_CTX * c, const void *data, size_t len)                                                          \
  {                                                                                                                                 \
    psa_status_t status = PSA_ERROR_GENERIC_ERROR;                                                                                  \
    PSA_CRYPTO_MUTEX_LOCK                                                                                                           \
      status = psa_hash_update(&c->operation, (const uint8_t *) data, len);                                                         \
    PSA_CRYPTO_MUTEX_UNLOCK                                                                                                         \
    return (status == PSA_SUCCESS);                                                                                                 \
  }                                                                                                                                 \
                                                                                                                                    \
  static int name##_Final(PSA_HASH_CTX * c, void * out, size_t * outl, size_t outsz)                                                \
  {                                                                                                                                 \
    psa_status_t status = PSA_ERROR_GENERIC_ERROR;                                                                                  \
    PSA_CRYPTO_MUTEX_LOCK                                                                                                           \
      status = psa_hash_finish(&c->operation, (uint8_t *) out, outsz, outl);                                                        \
    PSA_CRYPTO_MUTEX_UNLOCK                                                                                                         \
    return (status == PSA_SUCCESS);                                                                                                 \
  }                                                                                                                                 \
                                                                                                                                    \
                                                                                                                                    \
  static int name##_get_params(OSSL_PARAM params[])                                                                                 \
  {                                                                                                                                 \
    return ossl_digest_default_get_params(params, PSA_HASH_BLOCK_LENGTH(alg), PSA_HASH_LENGTH(alg), PROV_DIGEST_FLAG_ALGID_ABSENT); \
  }                                                                                                                                 \
                                                                                                                                    \
  const OSSL_DISPATCH ossl_##name##_functions[] = {                                                                                 \
    { OSSL_FUNC_DIGEST_NEWCTX, (void (*)(void))name##_newctx },                                                                     \
    { OSSL_FUNC_DIGEST_INIT, (void (*)(void))name##_Init },                                                                         \
    { OSSL_FUNC_DIGEST_UPDATE, (void (*)(void))name##_Update },                                                                     \
    { OSSL_FUNC_DIGEST_FINAL, (void (*)(void))name##_Final },                                                                       \
    { OSSL_FUNC_DIGEST_FREECTX, (void (*)(void))name##_freectx },                                                                   \
    { OSSL_FUNC_DIGEST_DUPCTX, (void (*)(void))name##_dupctx },                                                                     \
    { OSSL_FUNC_DIGEST_GET_PARAMS, (void (*)(void))name##_get_params },                                                             \
    { 0, NULL }                                                                                                                     \
  };

IMPLEMENT_hashing_operation(sha224, PSA_ALG_SHA_224)
IMPLEMENT_hashing_operation(sha256, PSA_ALG_SHA_256)
IMPLEMENT_hashing_operation(sha384, PSA_ALG_SHA_384)
IMPLEMENT_hashing_operation(sha512, PSA_ALG_SHA_512)
