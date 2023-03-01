#ifndef SLI_PSA_OMIPRESENT_H
#define SLI_PSA_OMIPRESENT_H

#if defined(TFM_CONFIG_SL_SECURE_LIBRARY)

// Asymmetric Crypt module (RSA is not supported)
#define TFM_CRYPTO_ASYM_ENCRYPT_MODULE_DISABLED

// HASH module
#if !defined(PSA_WANT_ALG_SHA_1) \
    && !defined(PSA_WANT_ALG_SHA_224) \
    && !defined(PSA_WANT_ALG_SHA_256) \
    && !defined(PSA_WANT_ALG_SHA_384) \
    && !defined(PSA_WANT_ALG_SHA_512) \
    && !defined(PSA_WANT_ALG_MD5)
  #define TFM_CRYPTO_HASH_MODULE_DISABLED
#endif

// AEAD module
#if !defined(PSA_WANT_ALG_CCM) \
    && !defined(PSA_WANT_ALG_GCM) \
    && !defined(PSA_WANT_ALG_CHACHA20_POLY1305)
  #define TFM_CRYPTO_AEAD_MODULE_DISABLED
#endif

// Asymmetric Sign module
#if !defined(PSA_WANT_ALG_ECDSA) \
    && !defined(PSA_WANT_ALG_EDDSA) \
    && !defined(PSA_WANT_ALG_DETERMINISTIC_ECDSA)
  #define TFM_CRYPTO_ASYM_SIGN_MODULE_DISABLED
#endif

// Cipher module
#if !defined(PSA_WANT_ALG_CFB) \
    && !defined(PSA_WANT_ALG_CTR) \
    && !defined(PSA_WANT_ALG_CBC_NO_PADDING) \
    && !defined(PSA_WANT_ALG_CBC_PKCS7) \
    && !defined(PSA_WANT_ALG_ECB_NO_PADDING) \
    && !defined(PSA_WANT_ALG_XTS) \
    && !defined(PSA_WANT_ALG_OFB) \
    && !defined(PSA_WANT_ALG_STREAM_CIPHER)
  #define TFM_CRYPTO_CIPHER_MODULE_DISABLED
#endif

// MAC module
#if !defined(PSA_WANT_ALG_HMAC) \
     && !defined(PSA_WANT_ALG_CMAC) \
     && !defined(PSA_WANT_ALG_CBC_MAC)
  #define TFM_CRYPTO_MAC_MODULE_DISABLED
#endif

// Key derivation module
#if !defined(PSA_WANT_ALG_PBKDF2_HMAC) \
    && !defined(PSA_WANT_ALG_HKDF) \
    && !defined(PSA_WANT_ALG_PBKDF2_AES_CMAC_PRF_128) \
    && !defined(PSA_WANT_ALG_TLS12_PRF) \
    && !defined(PSA_WANT_ALG_TLS12_PSK_TO_MS) \
    && !defined(PSA_WANT_ALG_ECDH)
  #define TFM_CRYPTO_KEY_DERIVATION_MODULE_DISABLED
#endif

#endif // TFM_CONFIG_SL_SECURE_LIBRARY

#endif // SLI_PSA_OMIPRESENT_H
