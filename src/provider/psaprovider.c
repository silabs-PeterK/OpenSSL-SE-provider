/*
 * Copyright 2019-2022 The OpenSSL Project Authors. All Rights Reserved.
 *
 * Licensed under the Apache License 2.0 (the "License").  You may not use
 * this file except in compliance with the License.  You can obtain a copy
 * in the file LICENSE in the source distribution or at
 * https://www.openssl.org/source/license.html
 */

#include <string.h>
#include <stdio.h>
#include <openssl/core.h>
#include <openssl/core_dispatch.h>
#include <openssl/core_names.h>
#include <openssl/err.h>
#include <openssl/params.h>
#include "prov/provider_ctx.h"
#include "prov/implementations.h"
#include "prov/names.h"
#include "prov/providercommon.h"

#include "common.h"
#include "implementations/hash_prov.h"
#include "implementations/cipher_prov.h"
#include "implementations/ciphercommon_gcm_local.c"

//required for cpc
#include "sl_cpc_se_primary.h"
#include "psa/crypto.h"
#include <signal.h>
#include <unistd.h>

#include <pthread.h>

// set this to 1 for more runtime log messages
#define DEBUG (1)
#define RETRY_COUNT (20u)

static cpc_handle_t lib_handle;
static bool run = true;
static char cpc_instance[100u];

pthread_mutex_t psa_crypto_mutex;
psa_key_id_t key_id_cnt;

static void signal_handler(int sig)
{
  (void)sig;
  run = false;
}

static void call_cpc_init(void)
{
  int ret;
  uint8_t retry = 0;
  strcpy(cpc_instance, "cpcd_0");

  // Set up custom signal handler for user interrupt and termination request.
  signal(SIGINT, signal_handler);
  signal(SIGTERM, signal_handler);

  // Initialize CPC communication
  do {
    ret = cpc_init(&lib_handle, cpc_instance, DEBUG, NULL);
    if (ret == 0) {
      // speed up boot process if everything seems ok
      break;
    }
    usleep(100000);
    retry++;
  } while ((ret != 0) && (retry < RETRY_COUNT));
  if (ret < 0) {
    perror("cpc_init: ");
    exit(EXIT_FAILURE);
  }
  ret = sl_cpc_se_init(&lib_handle);
  if (ret < 0) {
    printf("End point opening failed\n");
    perror("cpc_open_endpoint ");
    exit(EXIT_FAILURE);
  }
}
/*
 * Forward declarations to ensure that interface functions are correctly
 * defined.
 */

static OSSL_FUNC_provider_gettable_params_fn psa_gettable_params;
static OSSL_FUNC_provider_get_params_fn psa_get_params;
static OSSL_FUNC_provider_query_operation_fn psa_query;

#define ALG(NAMES, FUNC) { NAMES, "provider=psa", FUNC }

///TEST

/* Parameters we provide to the core */
static const OSSL_PARAM psa_param_types[] = {
  OSSL_PARAM_DEFN(OSSL_PROV_PARAM_NAME, OSSL_PARAM_UTF8_PTR, NULL, 0),
  OSSL_PARAM_DEFN(OSSL_PROV_PARAM_VERSION, OSSL_PARAM_UTF8_PTR, NULL, 0),
  OSSL_PARAM_DEFN(OSSL_PROV_PARAM_BUILDINFO, OSSL_PARAM_UTF8_PTR, NULL, 0),
  OSSL_PARAM_DEFN(OSSL_PROV_PARAM_STATUS, OSSL_PARAM_INTEGER, NULL, 0),
  OSSL_PARAM_END
};

static const OSSL_PARAM *psa_gettable_params(void *provctx)
{
  return psa_param_types;
}

static int psa_get_params(void *provctx, OSSL_PARAM params[])
{
  OSSL_PARAM *p;

  p = OSSL_PARAM_locate(params, OSSL_PROV_PARAM_NAME);
  if (p != NULL && !OSSL_PARAM_set_utf8_ptr(p, "PSA Crypto Provider")) {
    return OPENSSL_FAILURE;
  }
  p = OSSL_PARAM_locate(params, OSSL_PROV_PARAM_VERSION);
  if (p != NULL && !OSSL_PARAM_set_utf8_ptr(p, OPENSSL_VERSION_STR)) {
    return OPENSSL_FAILURE;
  }
  p = OSSL_PARAM_locate(params, OSSL_PROV_PARAM_BUILDINFO);
  if (p != NULL && !OSSL_PARAM_set_utf8_ptr(p, OPENSSL_FULL_VERSION_STR)) {
    return OPENSSL_FAILURE;
  }
  p = OSSL_PARAM_locate(params, OSSL_PROV_PARAM_STATUS);
  if (p != NULL && !OSSL_PARAM_set_int(p, ossl_prov_is_running())) {
    return OPENSSL_FAILURE;
  }
  return OPENSSL_SUCCESS;
}

static const OSSL_ALGORITHM psa_keymng[] = {
  //    ALG(PROV_NAMES_SHA2_256, ossl_sha256_functions),
  //    ALG(PROV_NAMES_SHA2_384, ossl_sha384_functions),
  //    ALG(PROV_NAMES_SHA2_512, ossl_sha512_functions),
  { NULL, NULL, NULL }
};
static const OSSL_ALGORITHM psa_ciphers[] = {
  ALG(PROV_NAMES_AES_256_GCM, ossl_aes256gcm_functions),
  // ALG(PROV_NAMES_AES_192_GCM, ossl_aes192gcm_functions),
  // ALG(PROV_NAMES_AES_128_GCM, ossl_aes128gcm_functions),
  // ALG(PROV_NAMES_AES_256_CCM, ossl_aes256ccm_functions),
//  ALG(PROV_NAMES_AES_192_CCM, ossl_aes192ccm_functions),
//  ALG(PROV_NAMES_AES_128_CCM, ossl_aes128ccm_functions),
  { NULL, NULL, NULL }
};

static const OSSL_ALGORITHM psa_digests[] = {
  ALG(PROV_NAMES_SHA2_224, ossl_sha224_functions),
  ALG(PROV_NAMES_SHA2_256, ossl_sha256_functions),
  ALG(PROV_NAMES_SHA2_384, ossl_sha384_functions),
  ALG(PROV_NAMES_SHA2_512, ossl_sha512_functions),
  { NULL, NULL, NULL }
};
static const OSSL_ALGORITHM *psa_query(void *provctx, int operation_id,
                                       int *no_cache)
{
  *no_cache = 0;
  switch (operation_id) {
    // case OSSL_OP_KEYMGMT:
    //  return psa_keymng;
    case OSSL_OP_DIGEST:
      return psa_digests;
    case OSSL_OP_CIPHER:
      return psa_ciphers;
  }
  return NULL;
}
/*
   static void psa_teardown(void *provctx)
   {
   //  OSSL_LIB_CTX_free(PROV_LIBCTX_OF(provctx));
    ossl_prov_ctx_free(provctx);
   }
 */
/* Functions we provide to the core */
static const OSSL_DISPATCH psa_dispatch_table[] = {
  //  { OSSL_FUNC_PROVIDER_TEARDOWN, (void (*)(void))psa_teardown },
  { OSSL_FUNC_PROVIDER_GETTABLE_PARAMS, (void (*)(void))psa_gettable_params },
  { OSSL_FUNC_PROVIDER_GET_PARAMS, (void (*)(void))psa_get_params },
  { OSSL_FUNC_PROVIDER_QUERY_OPERATION, (void (*)(void))psa_query },
  { 0, NULL }
};

OPENSSL_EXPORT int OSSL_provider_init(const OSSL_CORE_HANDLE *handle,
                                      const OSSL_DISPATCH *in,
                                      const OSSL_DISPATCH **out,
                                      void **provctx)
{
  // OSSL_LIB_CTX *libctx = NULL;

/*
    if ((*provctx = ossl_prov_ctx_new()) == NULL
 || (libctx = OSSL_LIB_CTX_new_child(handle, in)) == NULL) {
        OSSL_LIB_CTX_free(libctx);
        psa_teardown(*provctx);
 * provctx = NULL;
        return 0;
    }
    ossl_prov_ctx_set0_libctx(*provctx, libctx);
    ossl_prov_ctx_set0_handle(*provctx, handle);
 */

  call_cpc_init();
  psa_status_t status = psa_crypto_init();
  printf("Init status code: %" PRId32 "\n", status);
  *provctx = (void *)handle;
  *out = psa_dispatch_table;
  key_id_cnt = 1;
  return OPENSSL_SUCCESS;
}

int ossl_prov_is_running(void)
{
  return 1;
}
