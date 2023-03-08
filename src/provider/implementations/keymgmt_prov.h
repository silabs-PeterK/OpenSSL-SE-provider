//TODO - work just started, needed for ecdsa.



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
} PSA_HASH_CTX;

