#ifndef PSA_CIPHER_H
#define PSA_CIPHER_H

#include <stdint.h>
#include <stddef.h>

#include "../../../inc/common.h"
//#include "../../../inc/psa_crypto.h"

#define   AES_BLOCK_SIZE   16

struct psa_cipher_handle_st {
  int nid;
  int block_size;
  int key_size;
  int iv_size;
  unsigned long flags;
  int (*init) (EVP_CIPHER_CTX *ctx, const unsigned char *key,
               const unsigned char *iv, int enc);
  int (*do_cipher)(EVP_CIPHER_CTX *ctx, unsigned char *out,
                   const unsigned char *in, size_t inl);
  int (*cleanup) (EVP_CIPHER_CTX *);
  int ctx_size;
  EVP_CIPHER * evp_cipher;
  int (*ctrl) (EVP_CIPHER_CTX *, int type, int arg, void *ptr);
};
typedef struct psa_cipher_handle_st psa_cipher_handle;

struct psa_cipher_ctx_st {
  psa_cipher_operation_t operation;
  psa_key_id_t key;
};
typedef struct psa_cipher_ctx_st psa_cipher_CTX;

#define IMPLEMENT_cipher_operation(nid_arg, cipher, PSAKeyType, keySize, mode, PSAAlg, padding, blockSize, flags_arg) \
                                                                                                                      \
  static int cipher##_##keySize##_##mode##_##padding##_ctrl(EVP_CIPHER_CTX * ctx, int type, int arg, void *ptr)       \
  {                                                                                                                   \
                                                                                                                      \
    psa_status_t status = PSA_ERROR_GENERIC_ERROR;                                                                    \
    psa_cipher_CTX * psactx = (psa_cipher_CTX *) EVP_CIPHER_CTX_get_cipher_data(ctx);                                 \
    if (psactx == NULL) {                                                                                             \
      psactx = OPENSSL_zalloc(sizeof(psa_cipher_CTX));                                                                \
      EVP_CIPHER_CTX_set_cipher_data(ctx, (void*)psactx);                                                             \
    }                                                                                                                 \
                                                                                                                      \
    psa_key_attributes_t attributes;                                                                                  \
                                                                                                                      \
    switch (type) {                                                                                                   \
      case EVP_CTRL_SET_KEY_ID:                                                                                       \
      {                                                                                                               \
        psactx->key = arg;                                                                                            \
        break;                                                                                                        \
      }                                                                                                               \
      case EVP_CTRL_IMPORT_KEY:                                                                                       \
      {                                                                                                               \
        attributes = psa_key_attributes_init();                                                                       \
        psa_set_key_bits(&attributes, arg);                                                                           \
        psa_set_key_type(&attributes, PSAKeyType);                                                                    \
        psa_set_key_algorithm(&attributes, PSAAlg);                                                                   \
        psa_set_key_usage_flags(&attributes, PSA_KEY_USAGE_ENCRYPT | PSA_KEY_USAGE_DECRYPT);                          \
        psa_set_key_id(&attributes, psactx->key);                                                                     \
        psa_set_key_lifetime(&attributes,                                                                             \
                             PSA_KEY_LIFETIME_FROM_PERSISTENCE_AND_LOCATION(PSA_KEY_PERSISTENCE_DEFAULT,              \
                                                                            WRAP_KEY_LOCATION));                      \
        TEST_EQUAL(                                                                                                   \
          psa_import_key(&attributes, (const uint8_t *) ptr, (size_t) arg, &(psactx->key)),                           \
          PSA_SUCCESS, 0);                                                                                            \
        break;                                                                                                        \
      }                                                                                                               \
      case EVP_CTRL_EXPORT_KEY:                                                                                       \
      {                                                                                                               \
        size_t data_size;                                                                                             \
        TEST_EQUAL(                                                                                                   \
          psa_export_key(psactx->key, (uint8_t *) ptr, (size_t) arg, &data_size),                                     \
          PSA_SUCCESS, 0);                                                                                            \
        TEST_EQUAL(arg, data_size, 0);                                                                                \
        break;                                                                                                        \
      }                                                                                                               \
      default:                                                                                                        \
        return OPENSSL_FAILURE;                                                                                       \
    }                                                                                                                 \
    return OPENSSL_SUCCESS;                                                                                           \
  }                                                                                                                   \
                                                                                                                      \
  static int cipher##_##keySize##_##mode##_##padding##_init(EVP_CIPHER_CTX * ctx,                                     \
                                                            const unsigned char *key,                                 \
                                                            const unsigned char *iv,                                  \
                                                            int enc)                                                  \
  {                                                                                                                   \
    psa_status_t status = PSA_ERROR_GENERIC_ERROR;                                                                    \
    psa_cipher_CTX * psactx = (psa_cipher_CTX *) EVP_CIPHER_CTX_get_cipher_data(ctx);                                 \
    if (psactx == NULL) {                                                                                             \
      psactx = OPENSSL_zalloc(sizeof(psa_cipher_CTX));                                                                \
      EVP_CIPHER_CTX_set_cipher_data(ctx, (void*)psactx);                                                             \
    }                                                                                                                 \
    psactx->operation = psa_cipher_operation_init();                                                                  \
                                                                                                                      \
    switch (enc) {                                                                                                    \
      case 1:                                                                                                         \
        TEST_EQUAL(                                                                                                   \
          psa_cipher_encrypt_setup(&(psactx->operation), psactx->key, PSAAlg),                                     \
          PSA_SUCCESS, 0);                                                                                               \
        break;                                                                                                        \
      case 0:                                                                                                         \
        TEST_EQUAL(                                                                                                   \
          psa_cipher_decrypt_setup(&(psactx->operation), psactx->key, PSAAlg),                                     \
          PSA_SUCCESS, 0);                                                                                               \
        break;                                                                                                        \
      default:                                                                                                        \
        return OPENSSL_FAILURE;                                                                                       \
        break;                                                                                                        \
    }                                                                                                                 \
    TEST_EQUAL(                                                                                                       \
      psa_cipher_set_iv(&psactx->operation, (const uint8_t *) iv,                                                     \
                        PSA_CIPHER_IV_LENGTH(PSAKeyType, PSAAlg)),                                                 \
      PSA_SUCCESS, 0)                                                                                                    \
    return OPENSSL_SUCCESS;                                                                                           \
  }                                                                                                                   \
                                                                                                                      \
  static int cipher##_##keySize##_##mode##_##padding##_do_cipher(                                                     \
    EVP_CIPHER_CTX * ctx, unsigned char *out,                                                                         \
    const unsigned char *in, size_t inl)                                                                              \
  {                                                                                                                   \
    psa_cipher_CTX * psactx;                                                                                          \
    psa_status_t status = PSA_ERROR_GENERIC_ERROR;                                                                    \
    psactx = (psa_cipher_CTX *) EVP_CIPHER_CTX_get_cipher_data(ctx);                                                  \
                                                                                                                      \
    if ((in == NULL) || (inl = 0)) {                                                                                  \
      status = psa_cipher_abort(&(psactx->operation));                                                                \
      TEST_EQUAL(status, PSA_SUCCESS, 0)                                                                                 \
      return OPENSSL_SUCCESS;                                                                                         \
    }                                                                                                                 \
                                                                                                                      \
    size_t output_length;                                                                                             \
    status = psa_cipher_update(&(psactx->operation),                                                                  \
                               (const uint8_t *) in,                                                                  \
                               inl,                                                                                   \
                               (uint8_t *) out,                                                                       \
                               blockSize,                                                                             \
                               &output_length);                                                                       \
    TEST_EQUAL(blockSize, output_length, 0)                                                                           \
    TEST_EQUAL(status, PSA_SUCCESS, 0)                                                                                \
    return OPENSSL_SUCCESS;                                                                                           \
  }                                                                                                                   \
                                                                                                                      \
  static int cipher##_##keySize##_##mode##_##padding##_cleanup(                                                       \
    EVP_CIPHER_CTX * ctx)                                                                                             \
  {                                                                                                                   \
    printf("Cleanup callled\n");                                                                                      \
    return OPENSSL_SUCCESS;                                                                                           \
  }                                                                                                                   \
  static psa_cipher_handle cipher##_##keySize##_##mode##_##padding =                                                  \
  { .nid = nid_arg, .block_size = blockSize, .key_size = (keySize / 8),                                               \
    .iv_size = PSA_CIPHER_IV_LENGTH(PSAKeyType, PSAAlg), .flags = flags_arg,                                          \
    .init = cipher##_##keySize##_##mode##_##padding##_init,                                                           \
    .do_cipher = cipher##_##keySize##_##mode##_##padding##_do_cipher,                                                 \
    .cleanup = cipher##_##keySize##_##mode##_##padding##_cleanup,                                                     \
    .ctx_size = sizeof(psa_cipher_CTX), .evp_cipher = NULL,                                                           \
    .ctrl = cipher##_##keySize##_##mode##_##padding##_ctrl, };

IMPLEMENT_cipher_operation(NID_aes_128_cbc, aes, PSA_KEY_TYPE_AES, 128, cbc, PSA_ALG_CBC_NO_PADDING, nopadding, AES_BLOCK_SIZE, (EVP_CIPH_CBC_MODE | EVP_CIPH_NO_PADDING | EVP_CIPH_FLAG_CUSTOM_CIPHER))
IMPLEMENT_cipher_operation(NID_aes_192_cbc, aes, PSA_KEY_TYPE_AES, 192, cbc, PSA_ALG_CBC_NO_PADDING, nopadding, AES_BLOCK_SIZE, (EVP_CIPH_CBC_MODE | EVP_CIPH_NO_PADDING | EVP_CIPH_FLAG_CUSTOM_CIPHER))
IMPLEMENT_cipher_operation(NID_aes_256_cbc, aes, PSA_KEY_TYPE_AES, 256, cbc, PSA_ALG_CBC_NO_PADDING, nopadding, AES_BLOCK_SIZE, (EVP_CIPH_CBC_MODE | EVP_CIPH_NO_PADDING | EVP_CIPH_FLAG_CUSTOM_CIPHER))

//TODO compute based on psa_cipher_array
static int psa_cipher_nids[] = {
  NID_aes_128_cbc,
  NID_aes_192_cbc,
  NID_aes_256_cbc,
};

static psa_cipher_handle * psa_cipher_array[] = {
  &aes_128_cbc_nopadding,
  &aes_192_cbc_nopadding,
  &aes_256_cbc_nopadding,
};

EVP_CIPHER *PSA_initialize_cipher(psa_cipher_handle * cipher_handle);
void PSA_deinitialize_cipher(psa_cipher_handle * cipher_handle);

#endif // PSA_CIPHER_H
