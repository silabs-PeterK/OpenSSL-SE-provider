/*
 * Copyright 2023 Silicon Labs. All Rights Reserved.
 *
 * Licensed under the Apache License 2.0 (the "License").  You may not use
 * this file except in compliance with the License.  You can obtain a copy
 * in the file LICENSE in the source distribution or at
 * https://www.openssl.org/source/license.html
 */

#define GCM_IV_DEFAULT_SIZE 12
#include "thread_safety.h"

static int gcm_tls_init(PSA_CIPHER_CTX *dat, unsigned char *aad, size_t aad_len);
static int gcm_tls_iv_set_fixed(PSA_CIPHER_CTX *ctx, unsigned char *iv,
                                size_t len);
static int gcm_cipher_internal(PSA_CIPHER_CTX *ctx, unsigned char *out,
                               size_t *padlen, const unsigned char *in,
                               size_t len);
static int gcm_tls_cipher(PSA_CIPHER_CTX *ctx, unsigned char *out, size_t *padlen,
                          const unsigned char *in, size_t len);

static int psa_prov_set_key(psa_key_id_t key_id, size_t key_length,
                            psa_key_type_t type, psa_algorithm_t alg,
                            psa_key_usage_t usage_flags, const uint8_t *data, psa_key_persistence_t persistence)
{
  psa_key_attributes_t key_attr;
  psa_key_id_t key_id_local;
  PSA_CRYPTO_MUTEX_LOCK
    key_attr = psa_key_attributes_init();
  psa_set_key_type(&key_attr, type);
  psa_set_key_bits(&key_attr, key_length);
  psa_set_key_usage_flags(&key_attr, usage_flags);
  psa_set_key_algorithm(&key_attr, alg);
  psa_set_key_lifetime(&key_attr, PSA_KEY_LIFETIME_FROM_PERSISTENCE_AND_LOCATION(persistence, PSA_KEY_LOCATION_SL_SE_OPAQUE));
  psa_set_key_id(&key_attr, key_id);
  PSA_CRYPTO_MUTEX_UNLOCK
 // psa_destroy_key(key_id);

  TEST_RESULT_TS(psa_import_key(&key_attr, data, key_length / 8, &key_id_local), PSA_SUCCESS, PROV_R_KEY_SETUP_FAILED);

  TEST_EQUAL(key_id_local, key_id, PROV_R_KEY_SETUP_FAILED);
  return OPENSSL_SUCCESS;
}

/* increment counter (64-bit int) by 1 */
static void ctr64_inc(unsigned char *counter)
{
  int n = 8;
  unsigned char c;

  do {
    --n;
    c = counter[n];
    ++c;
    counter[n] = c;
    if (c > 0) {
      return;
    }
  } while (n > 0);
}

static int getivgen(PSA_CIPHER_CTX *ctx, unsigned char *out, size_t olen)
{
  TEST_EQUAL(ctx->iv_gen, 1, PROV_R_ALGORITHM_MISMATCH);
  TEST_EQUAL(ctx->key_set, 1, PROV_R_NO_KEY_SET);
  TEST_RESULT_TS(psa_aead_set_nonce(&ctx->aead_operation, (const uint8_t *)ctx->iv, ctx->ivlen), PSA_SUCCESS, PROV_R_FAILED_TO_SET_PARAMETER);
  if (olen == 0 || olen > ctx->ivlen) {
    olen = ctx->ivlen;
  }
  memcpy(out, ctx->iv + ctx->ivlen - olen, olen);
  /*
   * Invocation field will be at least 8 bytes in size and so no need
   * to check wrap around or increment more than last 8 bytes.
   */
  ctr64_inc(ctx->iv + ctx->ivlen - 8);
  ctx->iv_state = IV_STATE_COPIED;
  return OPENSSL_SUCCESS;
}
/* Modification to support thread safe calls to PSA crypto */
static int setivinv(PSA_CIPHER_CTX *ctx, unsigned char *in, size_t inl)
{
  TEST_EQUAL(ctx->iv_gen, 1, PROV_R_ALGORITHM_MISMATCH);
  TEST_EQUAL(ctx->key_set, 1, PROV_R_NO_KEY_SET);
  TEST_EQUAL(ctx->enc, 0, PROV_R_ALGORITHM_MISMATCH);

  memcpy(ctx->iv + ctx->ivlen - inl, in, inl);
  TEST_RESULT_TS(psa_aead_set_nonce(&ctx->aead_operation, (const uint8_t *)ctx->iv, ctx->ivlen), PSA_SUCCESS, PROV_R_FAILED_TO_SET_PARAMETER);

  ctx->iv_state = IV_STATE_COPIED;
  return OPENSSL_SUCCESS;
}

/* Copy from openssl, but with psa ontext */
int ossl_psa_gcm_get_ctx_params(void *vctx, OSSL_PARAM params[])
{
  PSA_CIPHER_CTX *ctx = (PSA_CIPHER_CTX *)vctx;
  OSSL_PARAM *p;
  size_t sz;

  p = OSSL_PARAM_locate(params, OSSL_CIPHER_PARAM_IVLEN);
  if (p != NULL && !OSSL_PARAM_set_size_t(p, ctx->ivlen)) {
    ERR_raise(ERR_LIB_PROV, PROV_R_FAILED_TO_SET_PARAMETER);
    return 0;
  }
  p = OSSL_PARAM_locate(params, OSSL_CIPHER_PARAM_KEYLEN);
  if (p != NULL && !OSSL_PARAM_set_size_t(p, ctx->keylen)) {
    ERR_raise(ERR_LIB_PROV, PROV_R_FAILED_TO_SET_PARAMETER);
    return 0;
  }
  p = OSSL_PARAM_locate(params, OSSL_CIPHER_PARAM_AEAD_TAGLEN);
  if (p != NULL) {
    size_t taglen = (ctx->taglen != UNINITIALISED_SIZET) ? ctx->taglen
                    : PSA_AEAD_TAG_MAX_SIZE;

    if (!OSSL_PARAM_set_size_t(p, taglen)) {
      ERR_raise(ERR_LIB_PROV, PROV_R_FAILED_TO_SET_PARAMETER);
      return 0;
    }
  }

  p = OSSL_PARAM_locate(params, OSSL_CIPHER_PARAM_IV);
  if (p != NULL) {
    if (ctx->iv_state == IV_STATE_UNINITIALISED) {
      return 0;
    }
    if (ctx->ivlen > p->data_size) {
      ERR_raise(ERR_LIB_PROV, PROV_R_INVALID_IV_LENGTH);
      return 0;
    }
    if (!OSSL_PARAM_set_octet_string(p, ctx->iv, ctx->ivlen)
        && !OSSL_PARAM_set_octet_ptr(p, &ctx->iv, ctx->ivlen)) {
      ERR_raise(ERR_LIB_PROV, PROV_R_FAILED_TO_SET_PARAMETER);
      return 0;
    }
  }

  p = OSSL_PARAM_locate(params, OSSL_CIPHER_PARAM_UPDATED_IV);
  if (p != NULL) {
    if (ctx->iv_state == IV_STATE_UNINITIALISED) {
      return 0;
    }
    if (ctx->ivlen > p->data_size) {
      ERR_raise(ERR_LIB_PROV, PROV_R_INVALID_IV_LENGTH);
      return 0;
    }
    if (!OSSL_PARAM_set_octet_string(p, ctx->iv, ctx->ivlen)
        && !OSSL_PARAM_set_octet_ptr(p, &ctx->iv, ctx->ivlen)) {
      ERR_raise(ERR_LIB_PROV, PROV_R_FAILED_TO_SET_PARAMETER);
      return 0;
    }
  }

  p = OSSL_PARAM_locate(params, OSSL_CIPHER_PARAM_AEAD_TLS1_AAD_PAD);
  if (p != NULL && !OSSL_PARAM_set_size_t(p, ctx->tls_aad_pad_sz)) {
    ERR_raise(ERR_LIB_PROV, PROV_R_FAILED_TO_SET_PARAMETER);
    return 0;
  }
  p = OSSL_PARAM_locate(params, OSSL_CIPHER_PARAM_AEAD_TAG);
  if (p != NULL) {
    sz = p->data_size;
    if (sz == 0
        || sz > EVP_GCM_TLS_TAG_LEN
        || !ctx->enc
        || ctx->taglen == UNINITIALISED_SIZET) {
      ERR_raise(ERR_LIB_PROV, PROV_R_INVALID_TAG);
      return 0;
    }
    if (!OSSL_PARAM_set_octet_string(p, ctx->buf, sz)) {
      ERR_raise(ERR_LIB_PROV, PROV_R_FAILED_TO_SET_PARAMETER);
      return 0;
    }
  }
  p = OSSL_PARAM_locate(params, OSSL_CIPHER_PARAM_AEAD_TLS1_GET_IV_GEN);
  if (p != NULL) {
    if (p->data == NULL
        || p->data_type != OSSL_PARAM_OCTET_STRING
        || !getivgen(ctx, p->data, p->data_size)) {
      return 0;
    }
  }
  return 1;
}

/* Copy from openssl, but with psa ontext */
int ossl_psa_gcm_set_ctx_params(void *vctx, const OSSL_PARAM params[])
{
  PSA_CIPHER_CTX *ctx = (PSA_CIPHER_CTX *)vctx;
  const OSSL_PARAM *p;
  const OSSL_PARAM *q;
  size_t sz;
  void *vp;

  if (params == NULL) {
    return 1;
  }

  p = OSSL_PARAM_locate_const(params, OSSL_CIPHER_PARAM_AEAD_TAG);
  if (p != NULL) {
    vp = ctx->buf;
    if (!OSSL_PARAM_get_octet_string(p, &vp, EVP_GCM_TLS_TAG_LEN, &sz)) {
      ERR_raise(ERR_LIB_PROV, PROV_R_FAILED_TO_GET_PARAMETER);
      return 0;
    }
    if (sz == 0 || ctx->enc) {
      ERR_raise(ERR_LIB_PROV, PROV_R_INVALID_TAG);
      return 0;
    }
    ctx->taglen = sz;
  }

  p = OSSL_PARAM_locate_const(params, OSSL_CIPHER_PARAM_AEAD_IVLEN);
  if (p != NULL) {
    if (!OSSL_PARAM_get_size_t(p, &sz)) {
      ERR_raise(ERR_LIB_PROV, PROV_R_FAILED_TO_GET_PARAMETER);
      return 0;
    }
    if (sz == 0 || sz > sizeof(ctx->iv)) {
      ERR_raise(ERR_LIB_PROV, PROV_R_INVALID_IV_LENGTH);
      return 0;
    }
    ctx->ivlen = sz;
  }

  p = OSSL_PARAM_locate_const(params, OSSL_CIPHER_PARAM_AEAD_TLS1_AAD);
  if (p != NULL) {
    if (p->data_type != OSSL_PARAM_OCTET_STRING) {
      ERR_raise(ERR_LIB_PROV, PROV_R_FAILED_TO_GET_PARAMETER);
      return 0;
    }
    sz = gcm_tls_init(ctx, p->data, p->data_size);
    if (sz == 0) {
      ERR_raise(ERR_LIB_PROV, PROV_R_INVALID_AAD);
      return 0;
    }
    ctx->tls_aad_pad_sz = sz;
  }

  p = OSSL_PARAM_locate_const(params, OSSL_CIPHER_PARAM_AEAD_TLS1_IV_FIXED);
  if (p != NULL) {
    if (p->data_type != OSSL_PARAM_OCTET_STRING) {
      ERR_raise(ERR_LIB_PROV, PROV_R_FAILED_TO_GET_PARAMETER);
      return 0;
    }
    if (gcm_tls_iv_set_fixed(ctx, p->data, p->data_size) == 0) {
      ERR_raise(ERR_LIB_PROV, PROV_R_FAILED_TO_GET_PARAMETER);
      return 0;
    }
  }
  p = OSSL_PARAM_locate_const(params, OSSL_CIPHER_PARAM_AEAD_TLS1_SET_IV_INV);
  if (p != NULL) {
    if (p->data == NULL
        || p->data_type != OSSL_PARAM_OCTET_STRING
        || !setivinv(ctx, p->data, p->data_size)) {
      return 0;
    }
  }

  p = OSSL_PARAM_locate_const(params, OSSL_CIPHER_PARAM_AEAD_SET_KEY_ID);
  if (p != NULL) {
    if (p->data == NULL) {
      ERR_raise(ERR_LIB_PROV, PROV_R_FAILED_TO_GET_PARAMETER);
      return 0;
    }
    uint32_t temp_key = 0;
    temp_key = *((uint8_t *)p->data + 3);
    temp_key <<= 8;
    temp_key |= *((uint8_t *)p->data + 2);
    temp_key <<= 8;
    temp_key |= *((uint8_t *)p->data + 1);
    temp_key <<= 8;
    temp_key |= *((uint8_t *)p->data);

    q = OSSL_PARAM_locate_const(params, OSSL_CIPHER_PARAM_AEAD_SET_KEY);
    if (q != NULL) {
      if (q->data == NULL
          || q->data_type != OSSL_PARAM_OCTET_STRING) {
        ERR_raise(ERR_LIB_PROV, PROV_R_FAILED_TO_GET_PARAMETER);
        return 0;
      }

      TEST_EQUAL(psa_prov_set_key(temp_key, (q->data_size) * 8, PSA_KEY_TYPE_AES, PSA_ALG_GCM,
                                  PSA_KEY_USAGE_ENCRYPT | PSA_KEY_USAGE_DECRYPT,
                                  (const uint8_t *) q->data, PSA_KEY_PERSISTENCE_DEFAULT),
                 OPENSSL_SUCCESS, PROV_R_FAILED_TO_GET_PARAMETER);
    }
    ctx->key = temp_key;
    ctx->key_set = 1;
  }

  return OPENSSL_SUCCESS;
}

/* Copy from openssl, but with psa ontext */
int ossl_psa_gcm_stream_update(void *vctx, unsigned char *out, size_t *outl,
                               size_t outsize, const unsigned char *in, size_t inl)
{
  PSA_CIPHER_CTX *ctx = (PSA_CIPHER_CTX *)vctx;

  if (inl == 0) {
    *outl = 0;
    return 1;
  }

  if (outsize < inl) {
    ERR_raise(ERR_LIB_PROV, PROV_R_OUTPUT_BUFFER_TOO_SMALL);
    return 0;
  }

  if (gcm_cipher_internal(ctx, out, outl, in, inl) <= 0) {
    ERR_raise(ERR_LIB_PROV, PROV_R_CIPHER_OPERATION_FAILED);
    return 0;
  }
  return 1;
}

/* Copy from openssl, but with psa ontext */
int ossl_psa_gcm_stream_final(void *vctx, unsigned char *out, size_t *outl,
                              size_t outsize)
{
  PSA_CIPHER_CTX *ctx = (PSA_CIPHER_CTX *)vctx;
  int i;

  if (!ossl_prov_is_running()) {
    return 0;
  }

  i = gcm_cipher_internal(ctx, out, outl, NULL, 0);
  if (i <= 0) {
    return 0;
  }

  *outl = 0;
  return 1;
}

/* Copy from openssl, but with psa ontext */
int ossl_psa_gcm_cipher(void *vctx,
                        unsigned char *out, size_t *outl, size_t outsize,
                        const unsigned char *in, size_t inl)
{
  PSA_CIPHER_CTX *ctx = (PSA_CIPHER_CTX *)vctx;

  if (!ossl_prov_is_running()) {
    return 0;
  }

  if (outsize < inl) {
    ERR_raise(ERR_LIB_PROV, PROV_R_OUTPUT_BUFFER_TOO_SMALL);
    return 0;
  }

  if (gcm_cipher_internal(ctx, out, outl, in, inl) <= 0) {
    return 0;
  }

  *outl = inl;
  return 1;
}

/*
 * See SP800-38D (GCM) Section 8 "Uniqueness requirement on IVS and keys"
 *
 * See also 8.2.2 RBG-based construction.
 * Random construction consists of a free field (which can be NULL) and a
 * random field which will use a DRBG that can return at least 96 bits of
 * entropy strength. (The DRBG must be seeded by the FIPS module).
 */
static int gcm_iv_generate(PSA_CIPHER_CTX *ctx, int offset)
{
  int sz = ctx->ivlen - offset;

  /* Must be at least 96 bits */
  if (sz <= 0 || ctx->ivlen < GCM_IV_DEFAULT_SIZE) {
    return OPENSSL_FAILURE;
  }

  /* Use DRBG to generate random iv */
  TEST_RESULT_TS(psa_generate_random((uint8_t *) (ctx->iv + offset), sz), PSA_SUCCESS, PROV_R_PARENT_CANNOT_GENERATE_RANDOM_NUMBERS);

  ctx->iv_state = IV_STATE_BUFFERED;
  ctx->iv_gen_rand = 1;
  return OPENSSL_SUCCESS;
}

/* Modification to support thread safe calls to PSA crypto */
static int gcm_cipher_internal(PSA_CIPHER_CTX *ctx, unsigned char *out,
                               size_t *padlen, const unsigned char *in,
                               size_t len)
{
  size_t olen = 0;
  size_t temp_olen = 0;
  size_t temp_olen2 = 0;
  int rv = OPENSSL_FAILURE;

  if (ctx->tls_aad_len != UNINITIALISED_SIZET) {
    return gcm_tls_cipher(ctx, out, padlen, in, len);
  }

  if (!ctx->key_set || ctx->iv_state == IV_STATE_FINISHED) {
    goto err;
  }

  /*
   * FIPS requires generation of AES-GCM IV's inside the FIPS module.
   * The IV can still be set externally (the security policy will state that
   * this is not FIPS compliant). There are some applications
   * where setting the IV externally is the only option available.
   */
  if (ctx->iv_state == IV_STATE_UNINITIALISED) {
    if (!ctx->enc || !gcm_iv_generate(ctx, 0)) {
      goto err;
    }
  }

  if (ctx->iv_state == IV_STATE_BUFFERED) {
    TEST_RESULT_TS_GTE(psa_aead_set_nonce(&ctx->aead_operation, (const uint8_t *)ctx->iv, ctx->ivlen), PSA_SUCCESS, PROV_R_FAILED_TO_SET_PARAMETER);
    ctx->iv_state = IV_STATE_COPIED;
  }

  if (in != NULL) {
    /*  The input is AAD if out is NULL */
    if (out == NULL) {
      TEST_RESULT_TS_GTE(psa_aead_update_ad(&ctx->aead_operation, (const uint8_t *)in, len), PSA_SUCCESS, PROV_R_CIPHER_OPERATION_FAILED);
    } else {
      /* The input is ciphertext OR plaintext */
      TEST_RESULT_TS_GTE(psa_aead_update(&ctx->aead_operation, (const uint8_t *)in, len, (uint8_t *)out, len, &temp_olen), PSA_SUCCESS, PROV_R_CIPHER_OPERATION_FAILED);
      TEST_EQUAL_GTE(len, temp_olen, PROV_R_CIPHER_OPERATION_FAILED);
    }
  } else {
    /* The tag must be set before actually decrypting data */
    if (!ctx->enc && ctx->taglen == UNINITIALISED_SIZET) {
      goto err;
    }

    if (ctx->enc) {
      TEST_RESULT_TS_GTE(psa_aead_finish(&ctx->aead_operation, NULL, 0, &temp_olen2, ctx->buf, ctx->taglen, &temp_olen), PSA_SUCCESS, PROV_R_CIPHER_OPERATION_FAILED);
      TEST_EQUAL_GTE(0, temp_olen2, PROV_R_CIPHER_OPERATION_FAILED);
      TEST_EQUAL_GTE(ctx->taglen, temp_olen, PROV_R_INVALID_TAG_LENGTH);
    } else {
      TEST_RESULT_TS_GTE(psa_aead_verify(&ctx->aead_operation, NULL, 0, &temp_olen2, ctx->buf, ctx->taglen), PSA_SUCCESS, PROV_R_CIPHER_OPERATION_FAILED);
    }
    ctx->iv_state = IV_STATE_FINISHED;     /* Don't reuse the IV */
    goto finish;
  }
  olen = len;
  finish:
  rv = OPENSSL_SUCCESS;
  *padlen = olen;
  return rv;
  err:
  TEST_RESULT_TS(psa_aead_abort(&ctx->aead_operation), PSA_SUCCESS, 0);
  *padlen = olen;
  return rv;
}

/* Copy from openssl, but with psa ontext */
static int gcm_tls_init(PSA_CIPHER_CTX *dat, unsigned char *aad, size_t aad_len)
{
  unsigned char *buf;
  size_t len;

  if (!ossl_prov_is_running() || aad_len != EVP_AEAD_TLS1_AAD_LEN) {
    return 0;
  }

  /* Save the aad for later use. */
  buf = dat->buf;
  memcpy(buf, aad, aad_len);
  dat->tls_aad_len = aad_len;

  len = buf[aad_len - 2] << 8 | buf[aad_len - 1];
  /* Correct length for explicit iv. */
  if (len < EVP_GCM_TLS_EXPLICIT_IV_LEN) {
    return 0;
  }
  len -= EVP_GCM_TLS_EXPLICIT_IV_LEN;

  /* If decrypting correct for tag too. */
  if (!dat->enc) {
    if (len < EVP_GCM_TLS_TAG_LEN) {
      return 0;
    }
    len -= EVP_GCM_TLS_TAG_LEN;
  }
  buf[aad_len - 2] = (unsigned char)(len >> 8);
  buf[aad_len - 1] = (unsigned char)(len & 0xff);
  /* Extra padding: tag appended to record. */
  return EVP_GCM_TLS_TAG_LEN;
}

/* Modification to support thread safe calls to PSA crypto */
static int gcm_tls_iv_set_fixed(PSA_CIPHER_CTX *ctx, unsigned char *iv,
                                size_t len)
{
  /* Special case: -1 length restores whole IV */
  if (len == (size_t)-1) {
    memcpy(ctx->iv, iv, ctx->ivlen);
    ctx->iv_gen = 1;
    ctx->iv_state = IV_STATE_BUFFERED;
    return 1;
  }
  /* Fixed field must be at least 4 bytes and invocation field at least 8 */
  if ((len < EVP_GCM_TLS_FIXED_IV_LEN)
      || (ctx->ivlen - (int)len) < EVP_GCM_TLS_EXPLICIT_IV_LEN) {
    return 0;
  }
  if (len > 0) {
    memcpy(ctx->iv, iv, len);
  }
  if (ctx->enc) {
    TEST_RESULT_TS(psa_generate_random((uint8_t *) (ctx->iv + len), ctx->ivlen - len), PSA_SUCCESS, PROV_R_PARENT_CANNOT_GENERATE_RANDOM_NUMBERS);
  }
  ctx->iv_gen = 1;
  ctx->iv_state = IV_STATE_BUFFERED;
  return 1;
}

static int gcm_tls_cipher(PSA_CIPHER_CTX *ctx, unsigned char *out, size_t *padlen,
                          const unsigned char *in, size_t len)
{
  int rv = OPENSSL_FAILURE;
  size_t arg = EVP_GCM_TLS_EXPLICIT_IV_LEN;
  size_t plen = 0;
  size_t olen = 0;
  unsigned char *tag = NULL;

  if (!ossl_prov_is_running() || !ctx->key_set) {
    goto err;
  }

  /* Encrypt/decrypt must be performed in place */
  if (out != in || len < (EVP_GCM_TLS_EXPLICIT_IV_LEN + EVP_GCM_TLS_TAG_LEN)) {
    goto err;
  }

  /*
   * Check for too many keys as per FIPS 140-2 IG A.5 "Key/IV Pair Uniqueness
   * Requirements from SP 800-38D".  The requirements is for one party to the
   * communication to fail after 2^64 - 1 keys.  We do this on the encrypting
   * side only.
   */
  if (ctx->enc && ++ctx->tls_enc_records == 0) {
    ERR_raise(ERR_LIB_PROV, PROV_R_TOO_MANY_RECORDS);
    goto err;
  }

  /*
   * Set IV from start of buffer or generate IV and write to start of
   * buffer.
   */
  /*
   * Set IV from start of buffer or generate IV and write to start of
   * buffer.
   */
  if (ctx->enc) {
    if (!getivgen(ctx, out, arg)) {
      goto err;
    }
  } else {
    if (!setivinv(ctx, out, arg)) {
      goto err;
    }
  }

  /* Fix buffer and length to point to payload */
  in += EVP_GCM_TLS_EXPLICIT_IV_LEN;
  out += EVP_GCM_TLS_EXPLICIT_IV_LEN;
  len -= EVP_GCM_TLS_EXPLICIT_IV_LEN + EVP_GCM_TLS_TAG_LEN;

  tag = ctx->enc ? out + len : (unsigned char *)in + len;

  /* 6.2.3.3 of RFC 5246 - we allways have AD */
  TEST_RESULT_TS_GTE(psa_aead_update_ad(&ctx->aead_operation, (const uint8_t *)ctx->buf,
                                        ctx->tls_aad_len), PSA_SUCCESS, PROV_R_CIPHER_OPERATION_FAILED);
  TEST_RESULT_TS_GTE(psa_aead_update(&ctx->aead_operation, (const uint8_t *)in,
                                     len, (uint8_t *)out, len, &olen), PSA_SUCCESS, PROV_R_CIPHER_OPERATION_FAILED);
  TEST_EQUAL_GTE(len, olen, PROV_R_CIPHER_OPERATION_FAILED)
  if (ctx->enc) {
    TEST_RESULT_TS_GTE(psa_aead_finish(&ctx->aead_operation, NULL, 0, NULL, tag, EVP_GCM_TLS_TAG_LEN, &olen), PSA_SUCCESS, PROV_R_CIPHER_OPERATION_FAILED);
    TEST_EQUAL_GTE(EVP_GCM_TLS_TAG_LEN, olen, PROV_R_CIPHER_OPERATION_FAILED);
    plen =  len + EVP_GCM_TLS_EXPLICIT_IV_LEN + EVP_GCM_TLS_TAG_LEN;
  } else {
    PSA_CRYPTO_MUTEX_LOCK
    if (psa_aead_verify(&ctx->aead_operation, NULL, 0, NULL, tag, EVP_GCM_TLS_TAG_LEN) != PSA_SUCCESS) {
      PSA_CRYPTO_MUTEX_UNLOCK
      OPENSSL_cleanse(out, len);
      goto err;
    }
    PSA_CRYPTO_MUTEX_UNLOCK
      plen = len;
  }
  rv = OPENSSL_SUCCESS;
  ctx->iv_state = IV_STATE_FINISHED;
  ctx->tls_aad_len = UNINITIALISED_SIZET;
  *padlen = plen;
  return rv;
  err:
  TEST_RESULT_TS(psa_aead_abort(&ctx->aead_operation), PSA_SUCCESS, 0);
  ctx->iv_state = IV_STATE_FINISHED;
  ctx->tls_aad_len = UNINITIALISED_SIZET;
  *padlen = plen;
  return rv;
}
