//
// Created by pespacek on 23.01.2023. This is not a full test, and definitly not production quality, it is just for developing purposes.
// For full test, use openssl test suite with custom config file.
// e.g.
// OPENSSL_CONF=/usr/local/ssl/openssl.cnf ../util/shlib_wrap.sh ./sha_test
// OPENSSL_CONF=/usr/local/ssl/openssl.cnf ../util/shlib_wrap.sh ./aesgcmtest
//

#include <stdio.h>
#include <stdlib.h>
#include <dlfcn.h>
#include <openssl/provider.h>
#include <openssl/params.h>
#include <openssl/core_names.h>
#include <openssl/err.h>
#include <openssl/evp.h>
#include <string.h>
#include <openssl/engine.h>
#include <sys/time.h>
#include "../inc/common.h"

#define T(e)                            \
  if (!(e)) {                           \
    printf("Error");                    \
    OpenSSLDie(__FILE__, __LINE__, #e); \
  }

#define TEST_ASSERT(e) { if ((test = (e))) {          \
                           printf("Test FAILED\n"); } \
                         else {                       \
                           printf("Test passed\n"); } }

#define TEST_true(a) (a == 1)
#define TEST_int_eq(a, b) (a == b)
#define TEST_mem_eq(a, m, b, n) a[m - 1] == b[n - 1] //not proper mem eq.

#define TEST_NOT_NULL(a)    \
  if (a == NULL) {          \
    return OPENSSL_FAILURE; \
  }

struct timeval begin, end;

int test_psa_crypto_hash_single()
{
  printf("_____________________________ \n");
  printf("test_psa_crypto_hash_single: \n");
  psa_status_t status;
  char msg[] = { 't', 'e', 's', 't', '-', 'd', 'a', 't', 'a' };
  uint8_t digest_buf[64] = { 0 };
  size_t digest_len = 0;

  gettimeofday(&begin, 0);
  status = psa_hash_compute(PSA_ALG_SHA_256,
                            (uint8_t *)msg,
                            sizeof(msg),
                            digest_buf,
                            sizeof(digest_buf),
                            &digest_len);
  gettimeofday(&end, 0);
  long seconds = end.tv_sec - begin.tv_sec;
  long microseconds = end.tv_usec - begin.tv_usec;
  double elapsed = seconds + microseconds * 1e-6;
  printf("Time measured: %.6f seconds.\n", elapsed);

  printf("Hash status code: %" PRId32 "\n", status);
  printf("Resulting hash: ");
  for (size_t i = 0; i < sizeof(digest_buf); ++i) {
    printf("%02X", digest_buf[i]);
  }
  printf("\n");
}

int test_provider_hash_single()
{
  printf("_____________________________ \n");
  printf("test_provider_hash_single:  \n");
  int ret = -3;
  char msg[] = { 't', 'e', 's', 't', '-', 'd', 'a', 't', 'a' };
  uint8_t digest_buf[64] = { 0 };
  size_t digest_len = 0;
  EVP_MD *md = NULL;
  int md_len;

  md = EVP_MD_fetch(NULL, "SHA256", NULL);
  TEST_NOT_NULL(md)
  gettimeofday(&begin, 0);
  ret = EVP_Digest((const void*) msg, sizeof(msg), (unsigned char *)digest_buf,
                   &digest_len, md, NULL);
  gettimeofday(&end, 0);
  long seconds = end.tv_sec - begin.tv_sec;
  long microseconds = end.tv_usec - begin.tv_usec;
  double elapsed = seconds + microseconds * 1e-6;
  printf("Time measured: %.6f seconds.\n", elapsed);

  printf("EVP digest status code: %i\n", ret);
  printf("Resulting hash: ");
  for (size_t i = 0; i < sizeof(digest_buf); ++i) {
    printf("%02X", digest_buf[i]);
  }
  printf("\n");
  EVP_MD_free(md);
  EVP_cleanup();
}

int test_psa_crypto_hash_multi()
{
  printf("_____________________________ \n");
  printf("test_psa_crypto_hash_multi: \n");
  psa_status_t status;
  char mess1[] = "Test Message\n";
  char mess2[] = "Hello World\n";
  unsigned char md_value[EVP_MAX_MD_SIZE];
  int md_len;
  psa_hash_operation_t operation;
  operation = psa_hash_operation_init();
  status = psa_hash_setup(&operation, PSA_ALG_SHA_256);
  printf("Hash init status code: %" PRId32 "\n", status);
  status = psa_hash_update(&operation, (const uint8_t *) mess1, strlen(mess1));
  printf("Hash update status code: %" PRId32 "\n", status);
  status = psa_hash_finish(&operation, (uint8_t *) md_value, PSA_HASH_LENGTH(PSA_ALG_SHA_256), &md_len);
  printf("Hash finish status code: %" PRId32 "\n Len %i\n", status, md_len);

  printf("Resulting hash: ");
  for (int i = 0; i < md_len; i++) {
    printf("%02x", md_value[i]);
  }
  printf("\n");
}

static const unsigned char gcm_key[] = {
  0xee, 0xbc, 0x1f, 0x57, 0x48, 0x7f, 0x51, 0x92, 0x1c, 0x04, 0x65, 0x66,
  0x5f, 0x8a, 0xe6, 0xd1, 0x65, 0x8b, 0xb2, 0x6d, 0xe6, 0xf8, 0xa0, 0x69,
  0xa3, 0x52, 0x02, 0x93, 0xa5, 0x72, 0x07, 0x8f
};
static const unsigned char gcm_iv[] = {
  0x99, 0xaa, 0x3e, 0x68, 0xed, 0x81, 0x73, 0xa0, 0xee, 0xd0, 0x66, 0x84
};
static const unsigned char gcm_pt[] = {
  0xf5, 0x6e, 0x87, 0x05, 0x5b, 0xc3, 0x2d, 0x0e, 0xeb, 0x31, 0xb2, 0xea,
  0xcc, 0x2b, 0xf2, 0xa5
};
static const unsigned char gcm_aad[] = {
  0x4d, 0x23, 0xc3, 0xce, 0xc3, 0x34, 0xb4, 0x9b, 0xdb, 0x37, 0x0c, 0x43,
  0x7f, 0xec, 0x78, 0xde
};
static const unsigned char gcm_ct[] = {
  0xf7, 0x26, 0x44, 0x13, 0xa8, 0x4c, 0x0e, 0x7c, 0xd5, 0x36, 0x86, 0x7e,
  0xb9, 0xf2, 0x17, 0x36
};
static const unsigned char gcm_tag[] = {
  0x67, 0xba, 0x05, 0x10, 0x26, 0x2a, 0xe4, 0x87, 0xd7, 0x37, 0xee, 0x62,
  0x98, 0xf7, 0x7e, 0x0c
};

static int do_encrypt(unsigned char *iv_gen, unsigned char *ct, int *ct_len,
                      unsigned char *tag, int *tag_len)
{
  int ret = 0;
  EVP_CIPHER_CTX *ctx = NULL;
  int outlen;
  unsigned char outbuf[64];

  *tag_len = 16;
  ctx = EVP_CIPHER_CTX_new();
  ret = TEST_true(EVP_EncryptInit_ex(ctx, EVP_aes_256_gcm(), NULL, NULL, NULL) > 0)
        && TEST_true(EVP_EncryptInit_ex(ctx, NULL, NULL, gcm_key,
                                        iv_gen != NULL ? NULL : gcm_iv) > 0)
        && TEST_true(EVP_EncryptUpdate(ctx, NULL, &outlen, gcm_aad,
                                       sizeof(gcm_aad)) > 0)
        && TEST_true(EVP_EncryptUpdate(ctx, ct, ct_len, gcm_pt,
                                       sizeof(gcm_pt)) > 0)
        && TEST_true(EVP_EncryptFinal_ex(ctx, outbuf, &outlen) > 0)
        && TEST_int_eq(EVP_CIPHER_CTX_get_tag_length(ctx), 16)
        && TEST_true(EVP_CIPHER_CTX_ctrl(ctx, EVP_CTRL_AEAD_GET_TAG, 16,
                                         tag) > 0)
        && TEST_true(iv_gen == NULL
                     || EVP_CIPHER_CTX_get_original_iv(ctx, iv_gen, 12));
  EVP_CIPHER_CTX_free(ctx);
  return ret;
}
static int do_encrypt_persistent(unsigned char *iv_gen, unsigned char *ct, int *ct_len,
                                 unsigned char *tag, int *tag_len)
{
  int ret = 0;
  EVP_CIPHER_CTX *ctx = NULL;
  int outlen;
  unsigned char outbuf[64];
  unsigned int key_id = 3236;
  psa_destroy_key(key_id);
  *tag_len = 16;
  ctx = EVP_CIPHER_CTX_new();

  OSSL_PARAM params[3] = {
    OSSL_PARAM_END, OSSL_PARAM_END, OSSL_PARAM_END
  };
  params[0] = OSSL_PARAM_construct_uint(OSSL_CIPHER_PARAM_AEAD_SET_KEY_ID,
                                        &key_id);
  params[1] = OSSL_PARAM_construct_octet_string(OSSL_CIPHER_PARAM_AEAD_SET_KEY,
                                                gcm_key, sizeof(gcm_key));
  ret = TEST_true(EVP_EncryptInit_ex(ctx, EVP_aes_256_gcm(), NULL, NULL, NULL) > 0)
        && TEST_true(EVP_CIPHER_CTX_set_params(ctx, params))
        && TEST_true(EVP_EncryptInit_ex(ctx, NULL, NULL, NULL,
                                        iv_gen != NULL ? NULL : gcm_iv) > 0)
        && TEST_true(EVP_EncryptUpdate(ctx, NULL, &outlen, gcm_aad,
                                       sizeof(gcm_aad)) > 0)
        && TEST_true(EVP_EncryptUpdate(ctx, ct, ct_len, gcm_pt,
                                       sizeof(gcm_pt)) > 0)
        && TEST_true(EVP_EncryptFinal_ex(ctx, outbuf, &outlen) > 0)
        && TEST_int_eq(EVP_CIPHER_CTX_get_tag_length(ctx), 16)
        && TEST_true(EVP_CIPHER_CTX_ctrl(ctx, EVP_CTRL_AEAD_GET_TAG, 16, tag) > 0)
        && TEST_true(iv_gen == NULL
                     || EVP_CIPHER_CTX_get_original_iv(ctx, iv_gen, 12));
  EVP_CIPHER_CTX_free(ctx);
  return ret;
}
static int do_decrypt_persistent(const unsigned char *iv, const unsigned char *ct,
                                 int ct_len, const unsigned char *tag, int tag_len)
{
  int ret = 0;
  EVP_CIPHER_CTX *ctx = NULL;
  int outlen, ptlen;
  unsigned char pt[32];
  unsigned char outbuf[32];
  unsigned int key_id = 3236;
  ctx = EVP_CIPHER_CTX_new();
  OSSL_PARAM params[2] = {
    OSSL_PARAM_END, OSSL_PARAM_END
  };
  params[0] = OSSL_PARAM_construct_uint(OSSL_CIPHER_PARAM_AEAD_SET_KEY_ID,
                                        &key_id);
  EVP_CIPHER *cipher = EVP_CIPHER_fetch(NULL, "AES-256-GCM", NULL);

  ret =  TEST_true(EVP_DecryptInit_ex(ctx, cipher, NULL,
                                      NULL, NULL) > 0)
        && TEST_true(EVP_CIPHER_CTX_set_params(ctx, params))
        && TEST_true(EVP_DecryptInit_ex(ctx, NULL, NULL, NULL, iv) > 0)
        && TEST_int_eq(EVP_CIPHER_CTX_get_tag_length(ctx), 16)
        && TEST_true(EVP_DecryptUpdate(ctx, NULL, &outlen, gcm_aad,
                                       sizeof(gcm_aad)) > 0)
        && TEST_true(EVP_DecryptUpdate(ctx, pt, &ptlen, ct,
                                       ct_len) > 0)
        && TEST_true(EVP_CIPHER_CTX_ctrl(ctx, EVP_CTRL_AEAD_SET_TAG,
                                         tag_len, (void *)tag) > 0)
        && TEST_true(EVP_DecryptFinal_ex(ctx, outbuf, &outlen) > 0)
        && TEST_mem_eq(gcm_pt, sizeof(gcm_pt), pt, ptlen);

  EVP_CIPHER_CTX_free(ctx);
  return ret;
}
static int do_decrypt(const unsigned char *iv, const unsigned char *ct,
                      int ct_len, const unsigned char *tag, int tag_len)
{
  int ret = 0;
  EVP_CIPHER_CTX *ctx = NULL;
  int outlen, ptlen;
  unsigned char pt[32];
  unsigned char outbuf[32];
  ctx = EVP_CIPHER_CTX_new();
  ret =  TEST_true(EVP_DecryptInit_ex(ctx, EVP_aes_256_gcm(), NULL,
                                      NULL, NULL) > 0)
        && TEST_true(EVP_DecryptInit_ex(ctx, NULL, NULL, gcm_key, iv) > 0)
        && TEST_int_eq(EVP_CIPHER_CTX_get_tag_length(ctx), 16)
        && TEST_true(EVP_DecryptUpdate(ctx, NULL, &outlen, gcm_aad,
                                       sizeof(gcm_aad)) > 0)
        && TEST_true(EVP_DecryptUpdate(ctx, pt, &ptlen, ct,
                                       ct_len) > 0)
        && TEST_true(EVP_CIPHER_CTX_ctrl(ctx, EVP_CTRL_AEAD_SET_TAG,
                                         tag_len, (void *)tag) > 0)
        && TEST_true(EVP_DecryptFinal_ex(ctx, outbuf, &outlen) > 0)
        && TEST_mem_eq(gcm_pt, sizeof(gcm_pt), pt, ptlen);

  EVP_CIPHER_CTX_free(ctx);
  return ret;
}

int test_provider_hash_multi()
{
  printf("_____________________________ \n");
  printf("test_provider_hash_multi: \n");

  int ret = -3;
  EVP_MD *md = NULL;
  int md_len;
  md = EVP_MD_fetch(NULL, "SHA256", NULL);
  TEST_NOT_NULL(md)

  char mess1[] = "Test Message\n";
  char mess2[] = "Hello World\n";
  unsigned char md_value[EVP_MAX_MD_SIZE];
  EVP_MD_CTX *mdctx = NULL;

  mdctx = EVP_MD_CTX_new();
  TEST_NOT_NULL(mdctx);

  ret = EVP_DigestInit(mdctx, md);
  printf("evp hash init status code: %i\n", ret);
  ret = EVP_DigestUpdate(mdctx, mess1, strlen(mess1));
  printf("evp hash update status code: %i\n", ret);
  ret = EVP_DigestFinal(mdctx, md_value, &md_len);
  printf("evp hash finish status code: %i\n Len %i\n", ret, md_len);

  printf("Resulting hash: ");
  for (int i = 0; i < md_len; i++) {
    printf("%02x", md_value[i]);
  }
  printf("\n");
  EVP_MD_CTX_destroy(mdctx);

/* Call this once before exit. */
  EVP_MD_free(md);
  EVP_cleanup();
}

int test_provider()
{
  OSSL_PROVIDER *prov = NULL;
  prov = OSSL_PROVIDER_load(NULL, "default");
  TEST_NOT_NULL(prov);

  //Get hash result from OpenSSL default provider
  test_provider_hash_single();
  test_provider_hash_multi();

  //Load PSA proovider
  OSSL_PROVIDER_unload(prov);
  prov = OSSL_PROVIDER_load(NULL, "libpsaprov");
  TEST_NOT_NULL(prov);

  //.................................................
  // HASH FUNCTIONS
  //.................................................

  //Get hash result from without from PSA crypto, without OpenSSL
  test_psa_crypto_hash_single();
  test_psa_crypto_hash_multi();

  //Get hash result from without from PSA crypto provider, via OpenSSL API
  test_provider_hash_single();
  test_provider_hash_multi();

  //.................................................
  // CIPHER FUNCTIONS
  //.................................................

  unsigned char tag[32];
  unsigned char ct[32];
  int ctlen = 0, taglen = 0;

  printf("\n%i\n", (do_encrypt(NULL, ct, &ctlen, tag, &taglen)
                    && TEST_mem_eq(gcm_ct, sizeof(gcm_ct), ct, ctlen)
                    && TEST_mem_eq(gcm_tag, sizeof(gcm_tag), tag, taglen)
                    && do_decrypt(gcm_iv, ct, ctlen, tag, taglen)));

  printf("\n%i\n", (do_encrypt_persistent(NULL, ct, &ctlen, tag, &taglen)
                    && TEST_mem_eq(gcm_ct, sizeof(gcm_ct), ct, ctlen)
                    && TEST_mem_eq(gcm_tag, sizeof(gcm_tag), tag, taglen)
                    && do_decrypt_persistent(gcm_iv, ct, ctlen, tag, taglen)));
  OSSL_PROVIDER_unload(prov);
  return OPENSSL_SUCCESS;
}

int test_engine()
{
  ENGINE_load_dynamic();

  ENGINE *eng = ENGINE_by_id("psaengine");

  if ( eng == NULL ) {
    printf("Could not Load Engine!\n");
    exit(1);
  }

  T(ENGINE_init(eng));

  printf("Engine name: %s \n", ENGINE_get_name(eng));
  if (!ENGINE_set_default_ciphers(eng)) {
    abort();
  }

  int ret = OPENSSL_FAILURE;

  EVP_CIPHER *ciph;
  ciph = (EVP_CIPHER *)EVP_get_cipherbynid(NID_aes_128_cbc);
  TEST_NOT_NULL(ciph)

  unsigned char pt[16];
  for (int i = 0; i < 16; i++) {
    pt[i] = 'p';
  }

  unsigned char ct[32];

  // Key to use for encrpytion and decryption
  unsigned char key[32];
  for (int i = 0; i < 32; i++) {
    key[i] = 'k';
  }

  // Initialization Vector
  unsigned char iv[16];
  for (int i = 0; i < 16; i++) {
    iv[i] = 'i';
  }

  OSSL_PARAM params[] = { OSSL_PARAM_END, OSSL_PARAM_END };

  int outlen;
  EVP_CIPHER_CTX *ctx = EVP_CIPHER_CTX_new();
  OPENSSL_assert(ctx);
  T(EVP_CIPHER_iv_length(ciph) == sizeof(iv));
  T(EVP_CIPHER_block_size(ciph) == 16);

  T(EVP_CipherInit(ctx, ciph, NULL, NULL, 0));

  T(EVP_CIPHER_CTX_ctrl(ctx, EVP_CTRL_SET_KEY_ID, 5, NULL));
  T(EVP_CIPHER_CTX_ctrl(ctx, EVP_CTRL_IMPORT_KEY, 16, key));
  printf("\n");
  for (int i = 0; i < 32; i++) {
    printf("%i ", key[i]);
  }
  printf("\n");
  T(EVP_CipherInit_ex(ctx, ciph, NULL, NULL, iv, 1));
  key[0] = 63;
  T(EVP_CipherUpdate(ctx, ct, &outlen, pt, 16));
  T(EVP_CipherFinal(ctx, ct + 16, &outlen));
  T(EVP_CIPHER_CTX_ctrl(ctx, EVP_CTRL_EXPORT_KEY, 16, key));
  printf("\n");
  for (int i = 0; i < 32; i++) {
    printf("%i ", key[i]);
  }
  printf("\n");

  T(EVP_CipherInit_ex(ctx, ciph, NULL, NULL, iv, 0));
  T(EVP_CipherUpdate(ctx, pt, &outlen, ct, 16));
  T(EVP_CipherFinal(ctx, pt, &outlen));
  printf("\n");
  for (int i = 0; i < 16; i++) {
    printf("%c", pt[i]);
  }
  printf("\n");
  EVP_CIPHER_CTX_free(ctx);
  EVP_CIPHER_free(ciph);

  if (ret) {
    printf("Some tests FAILED!\n");
  } else {
    printf("All tests passed!\n");
  }

  ENGINE_finish(eng);
  ENGINE_free(eng);
  return ret;
}

int main(void)
{
  if (test_provider() != OPENSSL_SUCCESS) {
    printf("Provider test failure");
  }
  // if (test_engine() != OPENSSL_SUCCESS) {
  //  printf("Engine test failure");
  //}

  exit(EXIT_SUCCESS);
}
