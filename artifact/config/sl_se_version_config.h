#ifndef SL_SE_VERSION_CONFIG_H
#define SL_SE_VERSION_CONFIG_H

// -----------------------------------------------------------------------------
// User exposed config options

/**
 * \def SL_SE_SUPPORT_FW_PRIOR_TO_1_2_2
 *
 * Enable software fallback for ECDH and ECC public key validation on xG21 devices
 * running SE firmware versions lower than 1.2.2.
 *
 * Due to other stability concerns, it is strongly recommended to upgrade these devices to
 * the latest firmware revision instead of turning on software fallback support.
 *
 * Not having fallback support will make ECDH operations, as well as PSA Crypto public key
 * import, return an error code on affected devices.
 */
// #define SL_SE_SUPPORT_FW_PRIOR_TO_1_2_2

/**
 * \def SL_SE_ASSUME_FW_AT_LEAST_1_2_2
 *
 * For enhanced performance: if it is guaranteed that all devices on which this library will
 * run are updated to at least SE FW 1.2.2, then turning on this option will remove certain
 * fallback checks, thereby reducing the amount of processing required for ECDH and public
 * key verification operations.
 */
// #define SL_SE_ASSUME_FW_AT_LEAST_1_2_2

/**
 * \def SL_SE_ASSUME_FW_UNAFFECTED_BY_ED25519_ERRATA
 *
 * For minimal code size and performance savings: if it is guaranteed that none
 * of the devices running this library has SE FWs in the range [1.2.2, 1.2.8],
 * then enabling this option will disable runtime version checks.
 */
// #define SL_SE_ASSUME_FW_UNAFFECTED_BY_ED25519_ERRATA

// -----------------------------------------------------------------------------
// Additional version related logic

// SL_SE_ASSUME_FW_AT_LEAST_1_2_10 is no longer in use, however, it is kept here
// for backwards compatibility. */
#if defined(SL_SE_ASSUME_FW_AT_LEAST_1_2_10)
  #define SL_SE_ASSUME_FW_AT_LEAST_1_2_2
  #define SL_SE_ASSUME_FW_UNAFFECTED_BY_ED25519_ERRATA
#endif

#if !defined(_SILICON_LABS_32B_SERIES_2_CONFIG_1)
  #undef SL_SE_ASSUME_FW_AT_LEAST_1_2_2
  #undef SL_SE_ASSUME_FW_UNAFFECTED_BY_ED25519_ERRATA
#endif

#endif // SL_SE_VERSION_CONFIG_H
