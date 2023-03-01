#ifndef SLI_MBEDTLS_OMIPRESENT_H
#define SLI_MBEDTLS_OMIPRESENT_H

#if defined(MBEDTLS_PLATFORM_NV_SEED_ALT)

  // Provide the NV seed function signatures since we have no specific header
  // for them.

  #include <stddef.h>

  int sli_nv_seed_read(unsigned char *buf, size_t buf_len);
  int sli_nv_seed_write(unsigned char *buf, size_t buf_len);

#endif // MBEDTLS_PLATFORM_NV_SEED_ALT


#if defined(MBEDTLS_PLATFORM_CALLOC_MACRO) && defined(MBEDTLS_PLATFORM_FREE_MACRO)
  
  // By default MBEDTLS_PLATFORM_CALLOC_MACRO and MBEDTLS_PLATFORM_FREE_MACRO are
  // defined in mbedtls_platform_dynamic_memory_allocation_config_default.slcc.
  // Alternative implementations can configure MBEDTLS_PLATFORM_CALLOC_MACRO and
  // MBEDTLS_PLATFORM_FREE_MACRO to use other platform specific implementations.
  // Alternatively some use cases may select runtime initialisation in the
  // application by explicitly calling mbedtls_platform_set_calloc_free() by
  // selecting mbedtls_platform_dynamic_memory_allocation_config_init_runtime.

  #include <stddef.h> 

  extern void *MBEDTLS_PLATFORM_CALLOC_MACRO( size_t n, size_t size );
  extern void MBEDTLS_PLATFORM_FREE_MACRO( void *ptr );

#endif // MBEDTLS_PLATFORM_CALLOC_MACRO && MBEDTLS_PLATFORM_FREE_MACRO

#endif // SLI_MBEDTLS_OMIPRESENT_H
