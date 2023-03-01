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
    
    //    strncpy(key, "KEY_ID:", 7)                                                                                \
    //    key[7] = psactx->key;                                                                                     \
    //    key[8] = (psactx->key) >> 8;                                                                              \
     //   key[9] = (psactx->key) >> 16;                                                                             \
     //   key[10] = (psactx->key) >> 24;                                

static int psaprov_key_import(void *keydata, int selection, const OSSL_PARAM params[]);
static int psaprov_key_export(void *keydata, int selection,
                              OSSL_CALLBACK *param_cb, void *cbarg);

static int psaprov_key_import(void *keydata, int selection, const OSSL_PARAM params[])
{
  psa_status_t status = PSA_ERROR_GENERIC_ERROR;
  psa_key_attributes_t key_attr;
  key_attr = psa_key_attributes_init();

  if ( params == NULL ) {
    return -1;
  }
  if ( strcmp(params[0].key, "psa_key_id") != 0) {
    return -1;
  }
  psa_key_id_t key = *(params[0].data);
  if ( strcmp(params[1].key, "psa_key_length") != 0) {
    return -1;
  }
  size_t data_length = *(params[1].data);
  psa_set_key_bits(&key_attr, *(params[1].data));
  if ( strcmp(params[2].key, "psa_key_type") != 0) {
    return -1;
  }
  psa_set_key_type(&key_attr, *(params[2].data));
  if ( strcmp(params[2].key, "psa_algorithm") == 0) {
    psa_set_key_algorithm(&key_attr, *(params[3].data));
  }
  if ( strcmp(params[2].key, "psa_usage_flags") == 0) {
    psa_set_key_usage_flags(&key_attr, *(params[3].data));
  }

  status = psa_import_key(&key_attr, (const uint8_t *) keydata,
                          data_length, key);
  return (status == PSA_SUCCESS);
}

static int psaprov_key_export(void *keydata, int selection,
                              OSSL_CALLBACK *param_cb, void *cbarg)
{
  psa_status_t status = PSA_ERROR_GENERIC_ERROR;
  OSSL_PARAM *params = NULL;
  int ret = -1;
  ret = param_cb(params, cbarg);
  if ( ret != 0 ) {
    return ret;
  }

  psa_key_attributes_t attributes;

  if ( params == NULL ) {
    return -1;
  }
  if ( strcmp(params[0].key, "psa_key_id") != 0) {
    return -1;
  }
  psa_key_id_t key = *(params[0].data);
  if ( strcmp(params[1].key, "data_length") != 0) {
    return -1;
  }
  size_t data_length = *(params[1].data);;

  status = psa_export_key(key, (uint8_t *) keydata, data_size, data_length);
  return (status == PSA_SUCCESS);
}

typedef struct HASHstate_st {
  psa_hash_operation_t * operation;
} psa_hash_CTX;

# define IMPLEMENT_hashing_operation(name, alg)                                       \
  static OSSL_FUNC_digest_newctx_fn name##_newctx;                                    \
  static OSSL_FUNC_digest_freectx_fn name##_freectx;                                  \
  static OSSL_FUNC_digest_dupctx_fn name##_dupctx;                                    \
                                                                                      \
  static void *name##_newctx(void *prov_ctx)                                          \
  {                                                                                   \
    psa_hash_CTX *ctx = ossl_prov_is_running() ? OPENSSL_zalloc(sizeof(*ctx)) : NULL; \
    return ctx;                                                                       \
  }                                                                                   \
                                                                                      \
  static void name##_freectx(void *vctx)                                              \
  {                                                                                   \
    psa_hash_CTX *ctx = (psa_hash_CTX *)vctx;                                         \
    OPENSSL_clear_free(ctx, sizeof(*ctx));                                            \
  }                                                                                   \
                                                                                      \
  static void *name##_dupctx(void *ctx)                                               \
  {                                                                                   \
    psa_hash_CTX *in = (psa_hash_CTX *)ctx;                                           \
    psa_hash_CTX *ret = ossl_prov_is_running() ? OPENSSL_malloc(sizeof(*ret)) : NULL; \
    if (ret != NULL) {                                                                \
      *ret = *in; }                                                                   \
    return ret;                                                                       \
  }                                                                                   \
                                                                                      \
  static int name##_Init(psa_hash_CTX * c, ossl_unused const OSSL_PARAM params[])     \
  {                                                                                   \
    if (!ossl_prov_is_running()) {                                                    \
      return 0; }                                                                     \
    psa_status_t status = PSA_ERROR_GENERIC_ERROR;                                    \
    status = psa_hash_setup(c->operation, alg);                                       \
    return (status == PSA_SUCCESS);                                                   \
  }                                                                                   \
                                                                                      \
  static int name##_Update(psa_hash_CTX * c, const void *data, size_t len)            \
  {                                                                                   \
    psa_status_t status = PSA_ERROR_GENERIC_ERROR;                                    \
    status = psa_hash_update(c->operation, (const uint8_t *) data, len);              \
    return (status == PSA_SUCCESS);                                                   \
  }                                                                                   \
                                                                                      \
  static int name##_Final(unsigned char *md, psa_hash_CTX * c)                        \
  {                                                                                   \
    psa_status_t status = PSA_ERROR_GENERIC_ERROR;                                    \
    size_t hash_length;                                                               \
    status = psa_hash_finish(c->operation, (uint8_t *) md, PSA_HASH_LENGTH            \
                               (alg), &hash_length);                                  \
    if (PSA_HASH_LENGTH(alg) != hash_length) {                                        \
      return -1; }                                                                    \
    return (status == PSA_SUCCESS);                                                   \
  }                                                                                   \
                                                                                      \
                                                                                      \
  static int name##_get_params(OSSL_PARAM params[])                                   \
  {                                                                                   \
    OSSL_PARAM *p = NULL;                                                             \
    p = OSSL_PARAM_locate(params, OSSL_DIGEST_PARAM_BLOCK_SIZE);                      \
    if (p != NULL && !OSSL_PARAM_set_size_t(p, 1)) {                                  \
      return 0; }                                                                     \
    p = OSSL_PARAM_locate(params, OSSL_DIGEST_PARAM_SIZE);                            \
    if (p != NULL && !OSSL_PARAM_set_size_t(p, 1)) {                                  \
      return 0; }                                                                     \
    return 1;                                                                         \
  }                                                                                   \
                                                                                      \
  const OSSL_DISPATCH ossl_##name##_functions[] = {                                   \
    { OSSL_FUNC_DIGEST_NEWCTX, (void (*)(void))name##_newctx },                       \
    { OSSL_FUNC_DIGEST_INIT, (void (*)(void))name##_Init },                           \
    { OSSL_FUNC_DIGEST_UPDATE, (void (*)(void))name##_Update },                       \
    { OSSL_FUNC_DIGEST_FINAL, (void (*)(void))name##_Final },                         \
    { OSSL_FUNC_DIGEST_FREECTX, (void (*)(void))name##_freectx },                     \
    { OSSL_FUNC_DIGEST_DUPCTX, (void (*)(void))name##_dupctx },                       \
    { OSSL_FUNC_DIGEST_GET_PARAMS, (void (*)(void))name##_get_params },               \
    { 0, NULL }                                                                       \
  };

IMPLEMENT_hashing_operation(sha256, PSA_ALG_SHA_256)
IMPLEMENT_hashing_operation(sha384, PSA_ALG_SHA_384)
