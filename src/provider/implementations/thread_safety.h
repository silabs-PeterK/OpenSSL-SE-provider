#include <pthread.h>

extern  pthread_mutex_t psa_crypto_mutex;
extern  pthread_mutex_t key_managment_mutex;

#define PSA_CRYPTO_MUTEX_LOCK pthread_mutex_lock(&psa_crypto_mutex);
#define PSA_CRYPTO_MUTEX_UNLOCK pthread_mutex_unlock(&psa_crypto_mutex);

#define TEST_RESULT_TS(function, b) \
  PSA_CRYPTO_MUTEX_LOCK             \
  if (function != b) {              \
    PSA_CRYPTO_MUTEX_UNLOCK         \
    printf("FAILURE");              \
    return OPENSSL_FAILURE;         \
  }                                 \
  PSA_CRYPTO_MUTEX_UNLOCK

#define end_of_file 1