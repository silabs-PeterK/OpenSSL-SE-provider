/*
 * Copyright 2019-2022 The OpenSSL Project Authors. All Rights Reserved.
 *
 * Licensed under the Apache License 2.0 (the "License").  You may not use
 * this file except in compliance with the License.  You can obtain a copy
 * in the file LICENSE in the source distribution or at
 * https://www.openssl.org/source/license.html
 */

#define SLI_PSA_DRIVER_HSE
#define SL_CATALOG_SE_CPC_PRIMARY_PRESENT
#include "public/sl_psa_values.h"
#include "psa/crypto.h"

#define OPENSSL_SUCCESS 1
#define OPENSSL_FAILURE 0

#define OSSL_CIPHER_PARAM_AEAD_SET_KEY_ID "setKeyID"     /* uint */
#define OSSL_CIPHER_PARAM_AEAD_SET_KEY "setKey"          /* octet_string */

# define         EVP_CTRL_IMPORT_KEY                      0x30
# define         EVP_CTRL_EXPORT_KEY                      0x31
# define         EVP_CTRL_SET_KEY_ID                      0x32

/// Location value for wrapped key (PSA_KEY_LOCATION_SLI_SE_OPAQUE)
#define WRAP_KEY_LOCATION       PSA_KEY_LOCATION_SL_SE_OPAQUE

#define TEST_EQUAL(a, b, errno)     \
  if (a != b) {                     \
    ERR_raise(ERR_LIB_PROV, errno); \
    return OPENSSL_FAILURE;         \
  }

#define TEST_EQUAL_GTE(a, b, errno) \
  if (a != b) {                     \
    goto err;                       \
  }

#define END 0
