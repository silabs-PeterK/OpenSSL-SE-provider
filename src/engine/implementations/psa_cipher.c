//
// Created by pespacek on 31.01.2023.
//

#include "psa_cipher.h"
#include <openssl/evp.h>

EVP_CIPHER *PSA_initialize_cipher(psa_cipher_handle * cipher_handle)
{
  if (cipher_handle == NULL) {
    return NULL;
  }
  if (cipher_handle->evp_cipher == NULL) {
    if ((cipher_handle->evp_cipher =
           EVP_CIPHER_meth_new(cipher_handle->nid,
                               cipher_handle->block_size,
                               cipher_handle->key_size)) == NULL
        || !EVP_CIPHER_meth_set_iv_length(cipher_handle->evp_cipher,
                                          cipher_handle->iv_size)
        || !EVP_CIPHER_meth_set_flags(cipher_handle->evp_cipher,
                                      cipher_handle->flags)
        || !EVP_CIPHER_meth_set_init(cipher_handle->evp_cipher,
                                     cipher_handle->init)
        || !EVP_CIPHER_meth_set_do_cipher(cipher_handle->evp_cipher,
                                          cipher_handle->do_cipher)
        || !EVP_CIPHER_meth_set_cleanup(cipher_handle->evp_cipher,
                                        cipher_handle->cleanup)
        || !EVP_CIPHER_meth_set_ctrl(cipher_handle->evp_cipher,
                                     cipher_handle->ctrl)
        || !EVP_CIPHER_meth_set_impl_ctx_size(cipher_handle->evp_cipher,
                                              cipher_handle->ctx_size)) {
      EVP_CIPHER_meth_free(cipher_handle->evp_cipher);
      cipher_handle->evp_cipher = NULL;
    }
  }

  return cipher_handle->evp_cipher;
}

void PSA_deinitialize_cipher(psa_cipher_handle * cipher_handle)
{
  if (cipher_handle->evp_cipher) {
    EVP_CIPHER_meth_free(cipher_handle->evp_cipher);
    cipher_handle->evp_cipher = NULL;
  }
}
