/*
 * Copyright 2023 Silicon Labs. All Rights Reserved.
 *
 * Licensed under the Apache License 2.0 (the "License").  You may not use
 * this file except in compliance with the License.  You can obtain a copy
 * in the file LICENSE in the source distribution or at
 * https://www.openssl.org/source/license.html
 */

#include <pthread.h>

extern  pthread_mutex_t psa_crypto_mutex;
extern  pthread_mutex_t key_managment_mutex;

#define PSA_CRYPTO_MUTEX_LOCK pthread_mutex_lock(&psa_crypto_mutex);
#define PSA_CRYPTO_MUTEX_UNLOCK pthread_mutex_unlock(&psa_crypto_mutex);

 #define TEST_RESULT_TS(function, b, errno) \
  PSA_CRYPTO_MUTEX_LOCK                     \
  if (function != b) {                      \
    PSA_CRYPTO_MUTEX_UNLOCK                 \
    ERR_raise(ERR_LIB_PROV, errno);         \
    return OPENSSL_FAILURE;                 \
  }                                         \
  PSA_CRYPTO_MUTEX_UNLOCK

#define TEST_RESULT_TS_GTE(function, b, errno) \
  PSA_CRYPTO_MUTEX_LOCK                        \
  if (function != b) {                         \
    PSA_CRYPTO_MUTEX_UNLOCK                    \
    ERR_raise(ERR_LIB_PROV, errno);            \
    goto err;                                  \
  }                                            \
  PSA_CRYPTO_MUTEX_UNLOCK

#define end_of_file 1
