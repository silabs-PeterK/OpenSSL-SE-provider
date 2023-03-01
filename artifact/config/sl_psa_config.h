#ifndef SLI_PSA_CONFIG_H
#define SLI_PSA_CONFIG_H

// -----------------------------------------------------------------------------
// User exposed config options

// <<< Use Configuration Wizard in Context Menu >>>

// <o SL_PSA_KEY_USER_SLOT_COUNT> PSA User Maximum Open Keys Count <0-128>
// <i> Maximum amount of keys that the user application will have open
// <i> simultaneously. In context of PSA Crypto, an open key means any key
// <i> either stored in RAM (lifetime set to PSA_KEY_LIFETIME_VOLATILE), or
// <i> used as part of a cryptographic operation.
// <i> When using a key for a multi-part (setup/update/finish) operation, a key
// <i> is considered to be open from the moment the operation is successfully
// <i> setup, until it finishes or aborts.
// <i> When an application tries to open more keys than this value accounts for,
// <i> the PSA API may return PSA_ERROR_INSUFFICIENT_MEMORY. Keep in mind that
// <i> other software included in the application (e.g. wireless protocol stacks)
// <i> also can have a need to have open keys in PSA Crypto. This could lead to
// <i> a race condition when the application key slot count is set too low for
// <i> the actual usage of the application, as a software stack may not fail
// <i> gracefully in case an application opens more than its declared amount of
// <i> keys, thereby precluding the stack from functioning.
// <i> Default: 4
#define SL_PSA_KEY_USER_SLOT_COUNT     (4)

// <o SL_PSA_ITS_USER_MAX_FILES> PSA Maximum User Persistent Keys Count <0-1024>
// <i> Maximum amount of keys (or other files) that can be stored persistently
// <i> by the application through the PSA interface, when persistent storage
// <i> support for PSA Crypto is included in the project.
// <i> Due to caching logic, this setting does have an impact on static RAM usage.
// <i> Note that this number is added to the potential requirements from other
// <i> software components in the project, such that the total amount of keys
// <i> which can be stored through the ITS backend can be higher than what is
// <i> configured here.
// <i>
// <i> WARNING: When changing this setting on an application that is already
// <i> deployed, and thus will get the change through an application upgrade,
// <i> care should be taken to ensure that the setting is only ever increased,
// <i> and never decreased. Decreasing this setting might cause previously
// <i> stored keys/files to become inaccessible.
// <i>
// <i> It is not possible to change this setting when using V3 ITS Driver.
// <i> The file-storage indexing is dependent on the  maximum number of files,
// <i> and if SL_PSA_ITS_USER_MAX_FILES is changed, ITS should be cleared and
// <i> all files need to be stored again.
// <i> Default: 128
#define SL_PSA_ITS_USER_MAX_FILES           (128)

// <o SL_PSA_ITS_SUPPORT_V1_DRIVER> Enable V1 Format Support For ITS Files <0-1>
// <i> Devices that used PSA ITS together with gecko_sdk_3.1.x  or earlier
// <i> might have keys (or other files) stored in V1 format.
// <i> If no v1 files are used, its support can be disabled for space
// <i> optimization.
// <i> Default: 1
#define SL_PSA_ITS_SUPPORT_V1_DRIVER 1

// <o SL_PSA_ITS_SUPPORT_V2_DRIVER> Enable V2 ITS Driver Support <0-1>
// <i> Devices that have used GSDK 4.1.x and earlier, and used ITS have the keys
// <i> (or other files) stored using different address range. Enabling this
// <i> config option adds upgrade code which converts V2 (and V1 if
// <i> supported) format ITS keys/files to the latest V3 format. Update is
// <i> fully automatic, needs to be run once and require extra flash space of
// <i> approximately the size of the largest key.
// <i> V1 ITS driver support can be disabled if the device has never used ITS
// <i> driver before in GSDK 4.1.x and earlier, or the keys has been already
// <i> migrated.
// <i> Default: 1
#define SL_PSA_ITS_SUPPORT_V2_DRIVER 1

// <o SL_PSA_ITS_SUPPORT_V3_DRIVER> Enable support for V3 ITS Driver <0-1>
// <i> Devices that have used GSDK 4.1.x and earlier, and used ITS have the keys
// <i> (or other files) stored using different address range. In rare case
// <i> that those devices have full nvm3 and not enough space for the
// <i> upgrade, (that requires an extra space to store largest key in memory
// <i> twice), this config option can disable v3 driver and use v2 one.
// <i> To upgrade the device, make space for the upgrade, and enable v3 driver again.
// <i>
// <i> WARNING: When using V3 driver, it is not possible to increase or decrease
// <i> the value of SL_PSA_ITS_USER_MAX_FILES. If the change of
// <i> SL_PSA_ITS_USER_MAX_FILES is required, ITS should be cleared and
// <i> all files need to be stored again.
// <i> Default: 0
#define SL_PSA_ITS_SUPPORT_V3_DRIVER 0

// <<< end of configuration section >>>

// -----------------------------------------------------------------------------
// Sub-files

#include "sli_psa_acceleration.h"

#if defined(SLI_PSA_CONFIG_AUTOGEN_OVERRIDE_FILE)
  #include SLI_PSA_CONFIG_AUTOGEN_OVERRIDE_FILE
#else
  #include "sli_psa_config_autogen.h"
#endif

#include "sli_psa_omnipresent.h"

#endif // SLI_PSA_CONFIG_H
