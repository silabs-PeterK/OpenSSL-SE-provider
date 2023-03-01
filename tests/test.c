//
// Created by pespacek on 23.01.2023.
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

struct timeval begin, end;

int test_psa_crypto_hash_single()
{
  printf("_____________________________ \n");
  printf("test_psa_crypto_hash_single: \n");
  psa_status_t status;
  char msg[] = { 't', 'e', 's', 't', '-', 'd', 'a', 't', 'a' };
  uint8_t digest_buf[32] = { 0 };
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
  uint8_t digest_buf[32] = { 0 };
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
  char mess1[] = "Test Message Test Message Test Message Test Message Test Message Test Message Test Message Test Message Test Message Test Message\n";
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

int test_provider_hash_multi()
{
  printf("_____________________________ \n");
  printf("test_provider_hash_multi: \n");

  int ret = -3;
  EVP_MD *md = NULL;
  int md_len;
  md = EVP_MD_fetch(NULL, "SHA256", NULL);
  TEST_NOT_NULL(md)

  char mess1[] = "Test Message Test Message Test Message Test Message Test Message Test Message Test Message Test Message Test Message Test Message\n";
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
static const unsigned char gcm_key[] = {
    0xee, 0xbc, 0x1f, 0x57, 0x48, 0x7f, 0x51, 0x92, 0x1c, 0x04, 0x65, 0x66,
    0x5f, 0x8a, 0xe6, 0xd1, 0x65, 0x8b, 0xb2, 0x6d, 0xe6, 0xf8, 0xa0, 0x69,
    0xa3, 0x52, 0x02, 0x93, 0xa5, 0x72, 0x07, 0x8f
};
int test_provider_cipher_multi()
{
  printf("_____________________________ \n");
  printf("test_provider_cipher_multi: \n");

  int ret = -3;
  EVP_CIPHER *cipher = NULL;
  int cipher_len;
  cipher = EVP_CIPHER_fetch(NULL, "AES-256-GCM", NULL);
  TEST_NOT_NULL(cipher)

  // Key to use for encrpytion and decryption
  unsigned char key[32];
  for (int i = 0; i < 32; i++) {
    key[i] = 'k';
  }

  char mess1[] = "Test Message 01\n";
  unsigned char ciphertext_value[EVP_MAX_BLOCK_LENGTH];
  EVP_CIPHER_CTX *cctx = NULL;

  cctx = EVP_CIPHER_CTX_new();
  TEST_NOT_NULL(cctx);

  ret = EVP_EncryptInit(cctx, cipher, gcm_key, NULL);
  printf("EVP_EncryptInit status code: %i\n", ret);
  ret = EVP_EncryptUpdate(cctx, ciphertext_value, &cipher_len, mess1, 16);
  printf("EVP_EncryptUpdate update status code: %i\n Len %i\n", ret, cipher_len);

  printf("Resulting ct: ");
  for (int i = 0; i < cipher_len; i++) {
    printf("%02x", ciphertext_value[i]);
  }
  ret = EVP_EncryptFinal(cctx, ciphertext_value, &cipher_len);
  printf("EVP_EncryptFinal status code: %i\n Len %i\n", ret, cipher_len);

  printf("Resulting ct: ");
  for (int i = 0; i < cipher_len; i++) {
    printf("%02x", ciphertext_value[i]);
  }
  printf("\n");
  EVP_CIPHER_CTX_free(cctx);

/* Call this once before exit. */
  EVP_CIPHER_free(cipher);
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

  //Get cipher result from OpenSSL default provider
//  test_provider_cipher_single();
  test_provider_cipher_multi();

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

  //Get cipher result from without from PSA crypto provider, via OpenSSL API
//  test_provider_cipher_single();
  test_provider_cipher_multi();

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

  //OPENSSL_add_all_algorithms_conf();

  EVP_CIPHER *ciph;
  ciph = (EVP_CIPHER *)EVP_get_cipherbynid(NID_aes_128_cbc);
  TEST_NOT_NULL(ciph)
  //ciph = EVP_CIPHER_fetch(NULL, NID_aes_128_cbc, NULL);
  //TEST_NOT_NULL(ciph)

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

  /* Generate cryptographically strong pseudo-random bytes for key and IV */
  // if (!RAND_bytes(iv, sizeof(iv)))  {
  //     /* OpenSSL reports a failure, act accordingly */
  //     fprintf(stderr, "ERROR: RAND_bytes iv error: %s\n", strerror(ERR_get_error() ));
  //     return ERR_get_error() ;
  // }

  OSSL_PARAM params[] = { OSSL_PARAM_END, OSSL_PARAM_END };
  // params[0] = OSSL_PARAM_construct_size_t("key-mesh", &v);

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
