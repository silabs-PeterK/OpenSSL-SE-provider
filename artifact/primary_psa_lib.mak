####################################################################
# Automatically-generated file. Do not edit!                       #
# Makefile Version 14                                              #
####################################################################

UNAME:=$(shell $(POSIX_TOOL_PATH)uname -s | $(POSIX_TOOL_PATH)sed -e 's/^\(CYGWIN\).*/\1/' | $(POSIX_TOOL_PATH)sed -e 's/^\(MINGW\).*/\1/')

COPIED_SDK_PATH ?= gecko_sdk_4.3.0

# This uses the explicit build rules below
PROJECT_SOURCE_FILES =

C_SOURCE_FILES   += $(filter %.c, $(PROJECT_SOURCE_FILES))
CXX_SOURCE_FILES += $(filter %.cpp, $(PROJECT_SOURCE_FILES))
CXX_SOURCE_FILES += $(filter %.cc, $(PROJECT_SOURCE_FILES))
ASM_SOURCE_FILES += $(filter %.s, $(PROJECT_SOURCE_FILES))
ASM_SOURCE_FILES += $(filter %.S, $(PROJECT_SOURCE_FILES))
LIB_FILES        += $(filter %.a, $(PROJECT_SOURCE_FILES))

C_DEFS += \
 '-DSLI_MBEDTLS_DEVICE_HSE_V2=1' \
 '-DSLI_MBEDTLS_DEVICE_HSE_VAULT_HIGH=1' \
 '-DSLI_MBEDTLS_DEVICE_SE_V2=1' \
 '-DSLI_SE_MAJOR_VERSION_TWO=1' \
 '-DSL_COMPONENT_CATALOG_PRESENT=1' \
 '-DMBEDTLS_CONFIG_FILE=<sl_mbedtls_config.h>' \
 '-DSLI_MBEDTLS_CONFIG_AUTOGEN_OVERRIDE_FILE=<sli_mbedtls_config_se_cpc_primary.h>' \
 '-DMBEDTLS_PSA_CRYPTO_CONFIG_FILE=<sl_psa_config.h>' \
 '-DSLI_PSA_CONFIG_AUTOGEN_OVERRIDE_FILE=<sli_psa_config_se_cpc_primary.h>' \
 '-DNO_CRYPTO_ACCELERATION=1'

ASM_DEFS += \
 '-DSLI_MBEDTLS_DEVICE_HSE_V2=1' \
 '-DSLI_MBEDTLS_DEVICE_HSE_VAULT_HIGH=1' \
 '-DSLI_MBEDTLS_DEVICE_SE_V2=1' \
 '-DSLI_SE_MAJOR_VERSION_TWO=1' \
 '-DSL_COMPONENT_CATALOG_PRESENT=1' \
 '-DMBEDTLS_CONFIG_FILE=<sl_mbedtls_config.h>' \
 '-DSLI_MBEDTLS_CONFIG_AUTOGEN_OVERRIDE_FILE=<sli_mbedtls_config_se_cpc_primary.h>' \
 '-DMBEDTLS_PSA_CRYPTO_CONFIG_FILE=<sl_psa_config.h>' \
 '-DSLI_PSA_CONFIG_AUTOGEN_OVERRIDE_FILE=<sli_psa_config_se_cpc_primary.h>' \
 '-DNO_CRYPTO_ACCELERATION=1'

INCLUDES += \
 -Iconfig \
 -Iautogen \
 -I$(COPIED_SDK_PATH)/platform/CMSIS/Core/Include \
 -I$(COPIED_SDK_PATH)/platform/emlib/inc \
 -I$(COPIED_SDK_PATH)/platform/security/sl_component/sl_mbedtls_support/config \
 -I$(COPIED_SDK_PATH)/platform/security/sl_component/sl_mbedtls_support/config/preset \
 -I$(COPIED_SDK_PATH)/util/third_party/mbedtls/include \
 -I$(COPIED_SDK_PATH)/util/third_party/mbedtls/library \
 -I$(COPIED_SDK_PATH)/platform/security/sl_component/sl_mbedtls_support/inc \
 -I$(COPIED_SDK_PATH)/platform/security/sl_component/sl_psa_driver/inc \
 -I$(COPIED_SDK_PATH)/platform/security/sl_component/sl_psa_driver/inc/public \
 -I$(COPIED_SDK_PATH)/platform/security/sl_component/sl_secure_engine_cpc/inc/common \
 -I$(COPIED_SDK_PATH)/platform/security/sl_component/sl_secure_engine_cpc/inc/primary \
 -I$(COPIED_SDK_PATH)/platform/security/sl_component/se_manager/inc \
 -I$(COPIED_SDK_PATH)/platform/common/inc

GROUP_START =
GROUP_END =

PROJECT_LIBS = \
 -lcpc \
 -lc \
 -lm

LIBS += $(GROUP_START) $(PROJECT_LIBS) $(GROUP_END)

LIB_FILES += $(filter %.a, $(PROJECT_LIBS))

C_FLAGS += \
 -std=c99 \
 -Wall \
 -Wextra \
 -Os

CXX_FLAGS += \
 -std=c++11 \
 -Wall \
 -Wextra \
 -Os

ASM_FLAGS += \

LD_FLAGS += \


####################################################################
# Pre/Post Build Rules                                             #
####################################################################
pre-build:
	# No pre-build defined

post-build: $(OUTPUT_DIR)/$(PROJECTNAME).out
	# No post-build defined

####################################################################
# SDK Build Rules                                                  #
####################################################################
$(OUTPUT_DIR)/sdk/platform/common/src/sl_assert.o: $(COPIED_SDK_PATH)/platform/common/src/sl_assert.c
	@$(POSIX_TOOL_PATH)echo 'Building $(COPIED_SDK_PATH)/platform/common/src/sl_assert.c'
	@$(POSIX_TOOL_PATH)mkdir -p $(@D)
	$(ECHO)$(CC) $(CFLAGS) -c -o $@ $(COPIED_SDK_PATH)/platform/common/src/sl_assert.c
CDEPS += $(OUTPUT_DIR)/sdk/platform/common/src/sl_assert.d
OBJS += $(OUTPUT_DIR)/sdk/platform/common/src/sl_assert.o

$(OUTPUT_DIR)/sdk/platform/emlib/src/em_se.o: $(COPIED_SDK_PATH)/platform/emlib/src/em_se.c
	@$(POSIX_TOOL_PATH)echo 'Building $(COPIED_SDK_PATH)/platform/emlib/src/em_se.c'
	@$(POSIX_TOOL_PATH)mkdir -p $(@D)
	$(ECHO)$(CC) $(CFLAGS) -c -o $@ $(COPIED_SDK_PATH)/platform/emlib/src/em_se.c
CDEPS += $(OUTPUT_DIR)/sdk/platform/emlib/src/em_se.d
OBJS += $(OUTPUT_DIR)/sdk/platform/emlib/src/em_se.o

$(OUTPUT_DIR)/sdk/platform/security/sl_component/se_manager/src/sl_se_manager.o: $(COPIED_SDK_PATH)/platform/security/sl_component/se_manager/src/sl_se_manager.c
	@$(POSIX_TOOL_PATH)echo 'Building $(COPIED_SDK_PATH)/platform/security/sl_component/se_manager/src/sl_se_manager.c'
	@$(POSIX_TOOL_PATH)mkdir -p $(@D)
	$(ECHO)$(CC) $(CFLAGS) -c -o $@ $(COPIED_SDK_PATH)/platform/security/sl_component/se_manager/src/sl_se_manager.c
CDEPS += $(OUTPUT_DIR)/sdk/platform/security/sl_component/se_manager/src/sl_se_manager.d
OBJS += $(OUTPUT_DIR)/sdk/platform/security/sl_component/se_manager/src/sl_se_manager.o

$(OUTPUT_DIR)/sdk/platform/security/sl_component/se_manager/src/sl_se_manager_attestation.o: $(COPIED_SDK_PATH)/platform/security/sl_component/se_manager/src/sl_se_manager_attestation.c
	@$(POSIX_TOOL_PATH)echo 'Building $(COPIED_SDK_PATH)/platform/security/sl_component/se_manager/src/sl_se_manager_attestation.c'
	@$(POSIX_TOOL_PATH)mkdir -p $(@D)
	$(ECHO)$(CC) $(CFLAGS) -c -o $@ $(COPIED_SDK_PATH)/platform/security/sl_component/se_manager/src/sl_se_manager_attestation.c
CDEPS += $(OUTPUT_DIR)/sdk/platform/security/sl_component/se_manager/src/sl_se_manager_attestation.d
OBJS += $(OUTPUT_DIR)/sdk/platform/security/sl_component/se_manager/src/sl_se_manager_attestation.o

$(OUTPUT_DIR)/sdk/platform/security/sl_component/se_manager/src/sl_se_manager_cipher.o: $(COPIED_SDK_PATH)/platform/security/sl_component/se_manager/src/sl_se_manager_cipher.c
	@$(POSIX_TOOL_PATH)echo 'Building $(COPIED_SDK_PATH)/platform/security/sl_component/se_manager/src/sl_se_manager_cipher.c'
	@$(POSIX_TOOL_PATH)mkdir -p $(@D)
	$(ECHO)$(CC) $(CFLAGS) -c -o $@ $(COPIED_SDK_PATH)/platform/security/sl_component/se_manager/src/sl_se_manager_cipher.c
CDEPS += $(OUTPUT_DIR)/sdk/platform/security/sl_component/se_manager/src/sl_se_manager_cipher.d
OBJS += $(OUTPUT_DIR)/sdk/platform/security/sl_component/se_manager/src/sl_se_manager_cipher.o

$(OUTPUT_DIR)/sdk/platform/security/sl_component/se_manager/src/sl_se_manager_entropy.o: $(COPIED_SDK_PATH)/platform/security/sl_component/se_manager/src/sl_se_manager_entropy.c
	@$(POSIX_TOOL_PATH)echo 'Building $(COPIED_SDK_PATH)/platform/security/sl_component/se_manager/src/sl_se_manager_entropy.c'
	@$(POSIX_TOOL_PATH)mkdir -p $(@D)
	$(ECHO)$(CC) $(CFLAGS) -c -o $@ $(COPIED_SDK_PATH)/platform/security/sl_component/se_manager/src/sl_se_manager_entropy.c
CDEPS += $(OUTPUT_DIR)/sdk/platform/security/sl_component/se_manager/src/sl_se_manager_entropy.d
OBJS += $(OUTPUT_DIR)/sdk/platform/security/sl_component/se_manager/src/sl_se_manager_entropy.o

$(OUTPUT_DIR)/sdk/platform/security/sl_component/se_manager/src/sl_se_manager_hash.o: $(COPIED_SDK_PATH)/platform/security/sl_component/se_manager/src/sl_se_manager_hash.c
	@$(POSIX_TOOL_PATH)echo 'Building $(COPIED_SDK_PATH)/platform/security/sl_component/se_manager/src/sl_se_manager_hash.c'
	@$(POSIX_TOOL_PATH)mkdir -p $(@D)
	$(ECHO)$(CC) $(CFLAGS) -c -o $@ $(COPIED_SDK_PATH)/platform/security/sl_component/se_manager/src/sl_se_manager_hash.c
CDEPS += $(OUTPUT_DIR)/sdk/platform/security/sl_component/se_manager/src/sl_se_manager_hash.d
OBJS += $(OUTPUT_DIR)/sdk/platform/security/sl_component/se_manager/src/sl_se_manager_hash.o

$(OUTPUT_DIR)/sdk/platform/security/sl_component/se_manager/src/sl_se_manager_key_derivation.o: $(COPIED_SDK_PATH)/platform/security/sl_component/se_manager/src/sl_se_manager_key_derivation.c
	@$(POSIX_TOOL_PATH)echo 'Building $(COPIED_SDK_PATH)/platform/security/sl_component/se_manager/src/sl_se_manager_key_derivation.c'
	@$(POSIX_TOOL_PATH)mkdir -p $(@D)
	$(ECHO)$(CC) $(CFLAGS) -c -o $@ $(COPIED_SDK_PATH)/platform/security/sl_component/se_manager/src/sl_se_manager_key_derivation.c
CDEPS += $(OUTPUT_DIR)/sdk/platform/security/sl_component/se_manager/src/sl_se_manager_key_derivation.d
OBJS += $(OUTPUT_DIR)/sdk/platform/security/sl_component/se_manager/src/sl_se_manager_key_derivation.o

$(OUTPUT_DIR)/sdk/platform/security/sl_component/se_manager/src/sl_se_manager_key_handling.o: $(COPIED_SDK_PATH)/platform/security/sl_component/se_manager/src/sl_se_manager_key_handling.c
	@$(POSIX_TOOL_PATH)echo 'Building $(COPIED_SDK_PATH)/platform/security/sl_component/se_manager/src/sl_se_manager_key_handling.c'
	@$(POSIX_TOOL_PATH)mkdir -p $(@D)
	$(ECHO)$(CC) $(CFLAGS) -c -o $@ $(COPIED_SDK_PATH)/platform/security/sl_component/se_manager/src/sl_se_manager_key_handling.c
CDEPS += $(OUTPUT_DIR)/sdk/platform/security/sl_component/se_manager/src/sl_se_manager_key_handling.d
OBJS += $(OUTPUT_DIR)/sdk/platform/security/sl_component/se_manager/src/sl_se_manager_key_handling.o

$(OUTPUT_DIR)/sdk/platform/security/sl_component/se_manager/src/sl_se_manager_signature.o: $(COPIED_SDK_PATH)/platform/security/sl_component/se_manager/src/sl_se_manager_signature.c
	@$(POSIX_TOOL_PATH)echo 'Building $(COPIED_SDK_PATH)/platform/security/sl_component/se_manager/src/sl_se_manager_signature.c'
	@$(POSIX_TOOL_PATH)mkdir -p $(@D)
	$(ECHO)$(CC) $(CFLAGS) -c -o $@ $(COPIED_SDK_PATH)/platform/security/sl_component/se_manager/src/sl_se_manager_signature.c
CDEPS += $(OUTPUT_DIR)/sdk/platform/security/sl_component/se_manager/src/sl_se_manager_signature.d
OBJS += $(OUTPUT_DIR)/sdk/platform/security/sl_component/se_manager/src/sl_se_manager_signature.o

$(OUTPUT_DIR)/sdk/platform/security/sl_component/se_manager/src/sl_se_manager_util.o: $(COPIED_SDK_PATH)/platform/security/sl_component/se_manager/src/sl_se_manager_util.c
	@$(POSIX_TOOL_PATH)echo 'Building $(COPIED_SDK_PATH)/platform/security/sl_component/se_manager/src/sl_se_manager_util.c'
	@$(POSIX_TOOL_PATH)mkdir -p $(@D)
	$(ECHO)$(CC) $(CFLAGS) -c -o $@ $(COPIED_SDK_PATH)/platform/security/sl_component/se_manager/src/sl_se_manager_util.c
CDEPS += $(OUTPUT_DIR)/sdk/platform/security/sl_component/se_manager/src/sl_se_manager_util.d
OBJS += $(OUTPUT_DIR)/sdk/platform/security/sl_component/se_manager/src/sl_se_manager_util.o

$(OUTPUT_DIR)/sdk/platform/security/sl_component/sl_mbedtls_support/src/error.o: $(COPIED_SDK_PATH)/platform/security/sl_component/sl_mbedtls_support/src/error.c
	@$(POSIX_TOOL_PATH)echo 'Building $(COPIED_SDK_PATH)/platform/security/sl_component/sl_mbedtls_support/src/error.c'
	@$(POSIX_TOOL_PATH)mkdir -p $(@D)
	$(ECHO)$(CC) $(CFLAGS) -c -o $@ $(COPIED_SDK_PATH)/platform/security/sl_component/sl_mbedtls_support/src/error.c
CDEPS += $(OUTPUT_DIR)/sdk/platform/security/sl_component/sl_mbedtls_support/src/error.d
OBJS += $(OUTPUT_DIR)/sdk/platform/security/sl_component/sl_mbedtls_support/src/error.o

$(OUTPUT_DIR)/sdk/platform/security/sl_component/sl_mbedtls_support/src/sli_psa_crypto.o: $(COPIED_SDK_PATH)/platform/security/sl_component/sl_mbedtls_support/src/sli_psa_crypto.c
	@$(POSIX_TOOL_PATH)echo 'Building $(COPIED_SDK_PATH)/platform/security/sl_component/sl_mbedtls_support/src/sli_psa_crypto.c'
	@$(POSIX_TOOL_PATH)mkdir -p $(@D)
	$(ECHO)$(CC) $(CFLAGS) -c -o $@ $(COPIED_SDK_PATH)/platform/security/sl_component/sl_mbedtls_support/src/sli_psa_crypto.c
CDEPS += $(OUTPUT_DIR)/sdk/platform/security/sl_component/sl_mbedtls_support/src/sli_psa_crypto.d
OBJS += $(OUTPUT_DIR)/sdk/platform/security/sl_component/sl_mbedtls_support/src/sli_psa_crypto.o

$(OUTPUT_DIR)/sdk/platform/security/sl_component/sl_mbedtls_support/src/version_features.o: $(COPIED_SDK_PATH)/platform/security/sl_component/sl_mbedtls_support/src/version_features.c
	@$(POSIX_TOOL_PATH)echo 'Building $(COPIED_SDK_PATH)/platform/security/sl_component/sl_mbedtls_support/src/version_features.c'
	@$(POSIX_TOOL_PATH)mkdir -p $(@D)
	$(ECHO)$(CC) $(CFLAGS) -c -o $@ $(COPIED_SDK_PATH)/platform/security/sl_component/sl_mbedtls_support/src/version_features.c
CDEPS += $(OUTPUT_DIR)/sdk/platform/security/sl_component/sl_mbedtls_support/src/version_features.d
OBJS += $(OUTPUT_DIR)/sdk/platform/security/sl_component/sl_mbedtls_support/src/version_features.o

$(OUTPUT_DIR)/sdk/platform/security/sl_component/sl_psa_driver/src/sli_psa_driver_common.o: $(COPIED_SDK_PATH)/platform/security/sl_component/sl_psa_driver/src/sli_psa_driver_common.c
	@$(POSIX_TOOL_PATH)echo 'Building $(COPIED_SDK_PATH)/platform/security/sl_component/sl_psa_driver/src/sli_psa_driver_common.c'
	@$(POSIX_TOOL_PATH)mkdir -p $(@D)
	$(ECHO)$(CC) $(CFLAGS) -c -o $@ $(COPIED_SDK_PATH)/platform/security/sl_component/sl_psa_driver/src/sli_psa_driver_common.c
CDEPS += $(OUTPUT_DIR)/sdk/platform/security/sl_component/sl_psa_driver/src/sli_psa_driver_common.d
OBJS += $(OUTPUT_DIR)/sdk/platform/security/sl_component/sl_psa_driver/src/sli_psa_driver_common.o

$(OUTPUT_DIR)/sdk/platform/security/sl_component/sl_psa_driver/src/sli_psa_driver_init.o: $(COPIED_SDK_PATH)/platform/security/sl_component/sl_psa_driver/src/sli_psa_driver_init.c
	@$(POSIX_TOOL_PATH)echo 'Building $(COPIED_SDK_PATH)/platform/security/sl_component/sl_psa_driver/src/sli_psa_driver_init.c'
	@$(POSIX_TOOL_PATH)mkdir -p $(@D)
	$(ECHO)$(CC) $(CFLAGS) -c -o $@ $(COPIED_SDK_PATH)/platform/security/sl_component/sl_psa_driver/src/sli_psa_driver_init.c
CDEPS += $(OUTPUT_DIR)/sdk/platform/security/sl_component/sl_psa_driver/src/sli_psa_driver_init.d
OBJS += $(OUTPUT_DIR)/sdk/platform/security/sl_component/sl_psa_driver/src/sli_psa_driver_init.o

$(OUTPUT_DIR)/sdk/platform/security/sl_component/sl_psa_driver/src/sli_psa_trng.o: $(COPIED_SDK_PATH)/platform/security/sl_component/sl_psa_driver/src/sli_psa_trng.c
	@$(POSIX_TOOL_PATH)echo 'Building $(COPIED_SDK_PATH)/platform/security/sl_component/sl_psa_driver/src/sli_psa_trng.c'
	@$(POSIX_TOOL_PATH)mkdir -p $(@D)
	$(ECHO)$(CC) $(CFLAGS) -c -o $@ $(COPIED_SDK_PATH)/platform/security/sl_component/sl_psa_driver/src/sli_psa_trng.c
CDEPS += $(OUTPUT_DIR)/sdk/platform/security/sl_component/sl_psa_driver/src/sli_psa_trng.d
OBJS += $(OUTPUT_DIR)/sdk/platform/security/sl_component/sl_psa_driver/src/sli_psa_trng.o

$(OUTPUT_DIR)/sdk/platform/security/sl_component/sl_psa_driver/src/sli_se_driver_aead.o: $(COPIED_SDK_PATH)/platform/security/sl_component/sl_psa_driver/src/sli_se_driver_aead.c
	@$(POSIX_TOOL_PATH)echo 'Building $(COPIED_SDK_PATH)/platform/security/sl_component/sl_psa_driver/src/sli_se_driver_aead.c'
	@$(POSIX_TOOL_PATH)mkdir -p $(@D)
	$(ECHO)$(CC) $(CFLAGS) -c -o $@ $(COPIED_SDK_PATH)/platform/security/sl_component/sl_psa_driver/src/sli_se_driver_aead.c
CDEPS += $(OUTPUT_DIR)/sdk/platform/security/sl_component/sl_psa_driver/src/sli_se_driver_aead.d
OBJS += $(OUTPUT_DIR)/sdk/platform/security/sl_component/sl_psa_driver/src/sli_se_driver_aead.o

$(OUTPUT_DIR)/sdk/platform/security/sl_component/sl_psa_driver/src/sli_se_driver_builtin_keys.o: $(COPIED_SDK_PATH)/platform/security/sl_component/sl_psa_driver/src/sli_se_driver_builtin_keys.c
	@$(POSIX_TOOL_PATH)echo 'Building $(COPIED_SDK_PATH)/platform/security/sl_component/sl_psa_driver/src/sli_se_driver_builtin_keys.c'
	@$(POSIX_TOOL_PATH)mkdir -p $(@D)
	$(ECHO)$(CC) $(CFLAGS) -c -o $@ $(COPIED_SDK_PATH)/platform/security/sl_component/sl_psa_driver/src/sli_se_driver_builtin_keys.c
CDEPS += $(OUTPUT_DIR)/sdk/platform/security/sl_component/sl_psa_driver/src/sli_se_driver_builtin_keys.d
OBJS += $(OUTPUT_DIR)/sdk/platform/security/sl_component/sl_psa_driver/src/sli_se_driver_builtin_keys.o

$(OUTPUT_DIR)/sdk/platform/security/sl_component/sl_psa_driver/src/sli_se_driver_cipher.o: $(COPIED_SDK_PATH)/platform/security/sl_component/sl_psa_driver/src/sli_se_driver_cipher.c
	@$(POSIX_TOOL_PATH)echo 'Building $(COPIED_SDK_PATH)/platform/security/sl_component/sl_psa_driver/src/sli_se_driver_cipher.c'
	@$(POSIX_TOOL_PATH)mkdir -p $(@D)
	$(ECHO)$(CC) $(CFLAGS) -c -o $@ $(COPIED_SDK_PATH)/platform/security/sl_component/sl_psa_driver/src/sli_se_driver_cipher.c
CDEPS += $(OUTPUT_DIR)/sdk/platform/security/sl_component/sl_psa_driver/src/sli_se_driver_cipher.d
OBJS += $(OUTPUT_DIR)/sdk/platform/security/sl_component/sl_psa_driver/src/sli_se_driver_cipher.o

$(OUTPUT_DIR)/sdk/platform/security/sl_component/sl_psa_driver/src/sli_se_driver_key_derivation.o: $(COPIED_SDK_PATH)/platform/security/sl_component/sl_psa_driver/src/sli_se_driver_key_derivation.c
	@$(POSIX_TOOL_PATH)echo 'Building $(COPIED_SDK_PATH)/platform/security/sl_component/sl_psa_driver/src/sli_se_driver_key_derivation.c'
	@$(POSIX_TOOL_PATH)mkdir -p $(@D)
	$(ECHO)$(CC) $(CFLAGS) -c -o $@ $(COPIED_SDK_PATH)/platform/security/sl_component/sl_psa_driver/src/sli_se_driver_key_derivation.c
CDEPS += $(OUTPUT_DIR)/sdk/platform/security/sl_component/sl_psa_driver/src/sli_se_driver_key_derivation.d
OBJS += $(OUTPUT_DIR)/sdk/platform/security/sl_component/sl_psa_driver/src/sli_se_driver_key_derivation.o

$(OUTPUT_DIR)/sdk/platform/security/sl_component/sl_psa_driver/src/sli_se_driver_key_management.o: $(COPIED_SDK_PATH)/platform/security/sl_component/sl_psa_driver/src/sli_se_driver_key_management.c
	@$(POSIX_TOOL_PATH)echo 'Building $(COPIED_SDK_PATH)/platform/security/sl_component/sl_psa_driver/src/sli_se_driver_key_management.c'
	@$(POSIX_TOOL_PATH)mkdir -p $(@D)
	$(ECHO)$(CC) $(CFLAGS) -c -o $@ $(COPIED_SDK_PATH)/platform/security/sl_component/sl_psa_driver/src/sli_se_driver_key_management.c
CDEPS += $(OUTPUT_DIR)/sdk/platform/security/sl_component/sl_psa_driver/src/sli_se_driver_key_management.d
OBJS += $(OUTPUT_DIR)/sdk/platform/security/sl_component/sl_psa_driver/src/sli_se_driver_key_management.o

$(OUTPUT_DIR)/sdk/platform/security/sl_component/sl_psa_driver/src/sli_se_driver_mac.o: $(COPIED_SDK_PATH)/platform/security/sl_component/sl_psa_driver/src/sli_se_driver_mac.c
	@$(POSIX_TOOL_PATH)echo 'Building $(COPIED_SDK_PATH)/platform/security/sl_component/sl_psa_driver/src/sli_se_driver_mac.c'
	@$(POSIX_TOOL_PATH)mkdir -p $(@D)
	$(ECHO)$(CC) $(CFLAGS) -c -o $@ $(COPIED_SDK_PATH)/platform/security/sl_component/sl_psa_driver/src/sli_se_driver_mac.c
CDEPS += $(OUTPUT_DIR)/sdk/platform/security/sl_component/sl_psa_driver/src/sli_se_driver_mac.d
OBJS += $(OUTPUT_DIR)/sdk/platform/security/sl_component/sl_psa_driver/src/sli_se_driver_mac.o

$(OUTPUT_DIR)/sdk/platform/security/sl_component/sl_psa_driver/src/sli_se_driver_signature.o: $(COPIED_SDK_PATH)/platform/security/sl_component/sl_psa_driver/src/sli_se_driver_signature.c
	@$(POSIX_TOOL_PATH)echo 'Building $(COPIED_SDK_PATH)/platform/security/sl_component/sl_psa_driver/src/sli_se_driver_signature.c'
	@$(POSIX_TOOL_PATH)mkdir -p $(@D)
	$(ECHO)$(CC) $(CFLAGS) -c -o $@ $(COPIED_SDK_PATH)/platform/security/sl_component/sl_psa_driver/src/sli_se_driver_signature.c
CDEPS += $(OUTPUT_DIR)/sdk/platform/security/sl_component/sl_psa_driver/src/sli_se_driver_signature.d
OBJS += $(OUTPUT_DIR)/sdk/platform/security/sl_component/sl_psa_driver/src/sli_se_driver_signature.o

$(OUTPUT_DIR)/sdk/platform/security/sl_component/sl_psa_driver/src/sli_se_opaque_driver_aead.o: $(COPIED_SDK_PATH)/platform/security/sl_component/sl_psa_driver/src/sli_se_opaque_driver_aead.c
	@$(POSIX_TOOL_PATH)echo 'Building $(COPIED_SDK_PATH)/platform/security/sl_component/sl_psa_driver/src/sli_se_opaque_driver_aead.c'
	@$(POSIX_TOOL_PATH)mkdir -p $(@D)
	$(ECHO)$(CC) $(CFLAGS) -c -o $@ $(COPIED_SDK_PATH)/platform/security/sl_component/sl_psa_driver/src/sli_se_opaque_driver_aead.c
CDEPS += $(OUTPUT_DIR)/sdk/platform/security/sl_component/sl_psa_driver/src/sli_se_opaque_driver_aead.d
OBJS += $(OUTPUT_DIR)/sdk/platform/security/sl_component/sl_psa_driver/src/sli_se_opaque_driver_aead.o

$(OUTPUT_DIR)/sdk/platform/security/sl_component/sl_psa_driver/src/sli_se_opaque_driver_cipher.o: $(COPIED_SDK_PATH)/platform/security/sl_component/sl_psa_driver/src/sli_se_opaque_driver_cipher.c
	@$(POSIX_TOOL_PATH)echo 'Building $(COPIED_SDK_PATH)/platform/security/sl_component/sl_psa_driver/src/sli_se_opaque_driver_cipher.c'
	@$(POSIX_TOOL_PATH)mkdir -p $(@D)
	$(ECHO)$(CC) $(CFLAGS) -c -o $@ $(COPIED_SDK_PATH)/platform/security/sl_component/sl_psa_driver/src/sli_se_opaque_driver_cipher.c
CDEPS += $(OUTPUT_DIR)/sdk/platform/security/sl_component/sl_psa_driver/src/sli_se_opaque_driver_cipher.d
OBJS += $(OUTPUT_DIR)/sdk/platform/security/sl_component/sl_psa_driver/src/sli_se_opaque_driver_cipher.o

$(OUTPUT_DIR)/sdk/platform/security/sl_component/sl_psa_driver/src/sli_se_opaque_driver_mac.o: $(COPIED_SDK_PATH)/platform/security/sl_component/sl_psa_driver/src/sli_se_opaque_driver_mac.c
	@$(POSIX_TOOL_PATH)echo 'Building $(COPIED_SDK_PATH)/platform/security/sl_component/sl_psa_driver/src/sli_se_opaque_driver_mac.c'
	@$(POSIX_TOOL_PATH)mkdir -p $(@D)
	$(ECHO)$(CC) $(CFLAGS) -c -o $@ $(COPIED_SDK_PATH)/platform/security/sl_component/sl_psa_driver/src/sli_se_opaque_driver_mac.c
CDEPS += $(OUTPUT_DIR)/sdk/platform/security/sl_component/sl_psa_driver/src/sli_se_opaque_driver_mac.d
OBJS += $(OUTPUT_DIR)/sdk/platform/security/sl_component/sl_psa_driver/src/sli_se_opaque_driver_mac.o

$(OUTPUT_DIR)/sdk/platform/security/sl_component/sl_psa_driver/src/sli_se_opaque_key_derivation.o: $(COPIED_SDK_PATH)/platform/security/sl_component/sl_psa_driver/src/sli_se_opaque_key_derivation.c
	@$(POSIX_TOOL_PATH)echo 'Building $(COPIED_SDK_PATH)/platform/security/sl_component/sl_psa_driver/src/sli_se_opaque_key_derivation.c'
	@$(POSIX_TOOL_PATH)mkdir -p $(@D)
	$(ECHO)$(CC) $(CFLAGS) -c -o $@ $(COPIED_SDK_PATH)/platform/security/sl_component/sl_psa_driver/src/sli_se_opaque_key_derivation.c
CDEPS += $(OUTPUT_DIR)/sdk/platform/security/sl_component/sl_psa_driver/src/sli_se_opaque_key_derivation.d
OBJS += $(OUTPUT_DIR)/sdk/platform/security/sl_component/sl_psa_driver/src/sli_se_opaque_key_derivation.o

$(OUTPUT_DIR)/sdk/platform/security/sl_component/sl_psa_driver/src/sli_se_transparent_driver_aead.o: $(COPIED_SDK_PATH)/platform/security/sl_component/sl_psa_driver/src/sli_se_transparent_driver_aead.c
	@$(POSIX_TOOL_PATH)echo 'Building $(COPIED_SDK_PATH)/platform/security/sl_component/sl_psa_driver/src/sli_se_transparent_driver_aead.c'
	@$(POSIX_TOOL_PATH)mkdir -p $(@D)
	$(ECHO)$(CC) $(CFLAGS) -c -o $@ $(COPIED_SDK_PATH)/platform/security/sl_component/sl_psa_driver/src/sli_se_transparent_driver_aead.c
CDEPS += $(OUTPUT_DIR)/sdk/platform/security/sl_component/sl_psa_driver/src/sli_se_transparent_driver_aead.d
OBJS += $(OUTPUT_DIR)/sdk/platform/security/sl_component/sl_psa_driver/src/sli_se_transparent_driver_aead.o

$(OUTPUT_DIR)/sdk/platform/security/sl_component/sl_psa_driver/src/sli_se_transparent_driver_cipher.o: $(COPIED_SDK_PATH)/platform/security/sl_component/sl_psa_driver/src/sli_se_transparent_driver_cipher.c
	@$(POSIX_TOOL_PATH)echo 'Building $(COPIED_SDK_PATH)/platform/security/sl_component/sl_psa_driver/src/sli_se_transparent_driver_cipher.c'
	@$(POSIX_TOOL_PATH)mkdir -p $(@D)
	$(ECHO)$(CC) $(CFLAGS) -c -o $@ $(COPIED_SDK_PATH)/platform/security/sl_component/sl_psa_driver/src/sli_se_transparent_driver_cipher.c
CDEPS += $(OUTPUT_DIR)/sdk/platform/security/sl_component/sl_psa_driver/src/sli_se_transparent_driver_cipher.d
OBJS += $(OUTPUT_DIR)/sdk/platform/security/sl_component/sl_psa_driver/src/sli_se_transparent_driver_cipher.o

$(OUTPUT_DIR)/sdk/platform/security/sl_component/sl_psa_driver/src/sli_se_transparent_driver_hash.o: $(COPIED_SDK_PATH)/platform/security/sl_component/sl_psa_driver/src/sli_se_transparent_driver_hash.c
	@$(POSIX_TOOL_PATH)echo 'Building $(COPIED_SDK_PATH)/platform/security/sl_component/sl_psa_driver/src/sli_se_transparent_driver_hash.c'
	@$(POSIX_TOOL_PATH)mkdir -p $(@D)
	$(ECHO)$(CC) $(CFLAGS) -c -o $@ $(COPIED_SDK_PATH)/platform/security/sl_component/sl_psa_driver/src/sli_se_transparent_driver_hash.c
CDEPS += $(OUTPUT_DIR)/sdk/platform/security/sl_component/sl_psa_driver/src/sli_se_transparent_driver_hash.d
OBJS += $(OUTPUT_DIR)/sdk/platform/security/sl_component/sl_psa_driver/src/sli_se_transparent_driver_hash.o

$(OUTPUT_DIR)/sdk/platform/security/sl_component/sl_psa_driver/src/sli_se_transparent_driver_mac.o: $(COPIED_SDK_PATH)/platform/security/sl_component/sl_psa_driver/src/sli_se_transparent_driver_mac.c
	@$(POSIX_TOOL_PATH)echo 'Building $(COPIED_SDK_PATH)/platform/security/sl_component/sl_psa_driver/src/sli_se_transparent_driver_mac.c'
	@$(POSIX_TOOL_PATH)mkdir -p $(@D)
	$(ECHO)$(CC) $(CFLAGS) -c -o $@ $(COPIED_SDK_PATH)/platform/security/sl_component/sl_psa_driver/src/sli_se_transparent_driver_mac.c
CDEPS += $(OUTPUT_DIR)/sdk/platform/security/sl_component/sl_psa_driver/src/sli_se_transparent_driver_mac.d
OBJS += $(OUTPUT_DIR)/sdk/platform/security/sl_component/sl_psa_driver/src/sli_se_transparent_driver_mac.o

$(OUTPUT_DIR)/sdk/platform/security/sl_component/sl_psa_driver/src/sli_se_transparent_key_derivation.o: $(COPIED_SDK_PATH)/platform/security/sl_component/sl_psa_driver/src/sli_se_transparent_key_derivation.c
	@$(POSIX_TOOL_PATH)echo 'Building $(COPIED_SDK_PATH)/platform/security/sl_component/sl_psa_driver/src/sli_se_transparent_key_derivation.c'
	@$(POSIX_TOOL_PATH)mkdir -p $(@D)
	$(ECHO)$(CC) $(CFLAGS) -c -o $@ $(COPIED_SDK_PATH)/platform/security/sl_component/sl_psa_driver/src/sli_se_transparent_key_derivation.c
CDEPS += $(OUTPUT_DIR)/sdk/platform/security/sl_component/sl_psa_driver/src/sli_se_transparent_key_derivation.d
OBJS += $(OUTPUT_DIR)/sdk/platform/security/sl_component/sl_psa_driver/src/sli_se_transparent_key_derivation.o

$(OUTPUT_DIR)/sdk/platform/security/sl_component/sl_psa_driver/src/sli_se_version_dependencies.o: $(COPIED_SDK_PATH)/platform/security/sl_component/sl_psa_driver/src/sli_se_version_dependencies.c
	@$(POSIX_TOOL_PATH)echo 'Building $(COPIED_SDK_PATH)/platform/security/sl_component/sl_psa_driver/src/sli_se_version_dependencies.c'
	@$(POSIX_TOOL_PATH)mkdir -p $(@D)
	$(ECHO)$(CC) $(CFLAGS) -c -o $@ $(COPIED_SDK_PATH)/platform/security/sl_component/sl_psa_driver/src/sli_se_version_dependencies.c
CDEPS += $(OUTPUT_DIR)/sdk/platform/security/sl_component/sl_psa_driver/src/sli_se_version_dependencies.d
OBJS += $(OUTPUT_DIR)/sdk/platform/security/sl_component/sl_psa_driver/src/sli_se_version_dependencies.o

$(OUTPUT_DIR)/sdk/platform/security/sl_component/sl_secure_engine_cpc/src/sl_se_cpc_primary.o: $(COPIED_SDK_PATH)/platform/security/sl_component/sl_secure_engine_cpc/src/sl_se_cpc_primary.c
	@$(POSIX_TOOL_PATH)echo 'Building $(COPIED_SDK_PATH)/platform/security/sl_component/sl_secure_engine_cpc/src/sl_se_cpc_primary.c'
	@$(POSIX_TOOL_PATH)mkdir -p $(@D)
	$(ECHO)$(CC) $(CFLAGS) -c -o $@ $(COPIED_SDK_PATH)/platform/security/sl_component/sl_secure_engine_cpc/src/sl_se_cpc_primary.c
CDEPS += $(OUTPUT_DIR)/sdk/platform/security/sl_component/sl_secure_engine_cpc/src/sl_se_cpc_primary.d
OBJS += $(OUTPUT_DIR)/sdk/platform/security/sl_component/sl_secure_engine_cpc/src/sl_se_cpc_primary.o

$(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/aes.o: $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/aes.c
	@$(POSIX_TOOL_PATH)echo 'Building $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/aes.c'
	@$(POSIX_TOOL_PATH)mkdir -p $(@D)
	$(ECHO)$(CC) $(CFLAGS) -c -o $@ $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/aes.c
CDEPS += $(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/aes.d
OBJS += $(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/aes.o

$(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/asn1parse.o: $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/asn1parse.c
	@$(POSIX_TOOL_PATH)echo 'Building $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/asn1parse.c'
	@$(POSIX_TOOL_PATH)mkdir -p $(@D)
	$(ECHO)$(CC) $(CFLAGS) -c -o $@ $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/asn1parse.c
CDEPS += $(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/asn1parse.d
OBJS += $(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/asn1parse.o

$(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/asn1write.o: $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/asn1write.c
	@$(POSIX_TOOL_PATH)echo 'Building $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/asn1write.c'
	@$(POSIX_TOOL_PATH)mkdir -p $(@D)
	$(ECHO)$(CC) $(CFLAGS) -c -o $@ $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/asn1write.c
CDEPS += $(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/asn1write.d
OBJS += $(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/asn1write.o

$(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/base64.o: $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/base64.c
	@$(POSIX_TOOL_PATH)echo 'Building $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/base64.c'
	@$(POSIX_TOOL_PATH)mkdir -p $(@D)
	$(ECHO)$(CC) $(CFLAGS) -c -o $@ $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/base64.c
CDEPS += $(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/base64.d
OBJS += $(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/base64.o

$(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/bignum.o: $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/bignum.c
	@$(POSIX_TOOL_PATH)echo 'Building $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/bignum.c'
	@$(POSIX_TOOL_PATH)mkdir -p $(@D)
	$(ECHO)$(CC) $(CFLAGS) -c -o $@ $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/bignum.c
CDEPS += $(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/bignum.d
OBJS += $(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/bignum.o

$(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/ccm.o: $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/ccm.c
	@$(POSIX_TOOL_PATH)echo 'Building $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/ccm.c'
	@$(POSIX_TOOL_PATH)mkdir -p $(@D)
	$(ECHO)$(CC) $(CFLAGS) -c -o $@ $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/ccm.c
CDEPS += $(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/ccm.d
OBJS += $(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/ccm.o

$(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/chacha20.o: $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/chacha20.c
	@$(POSIX_TOOL_PATH)echo 'Building $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/chacha20.c'
	@$(POSIX_TOOL_PATH)mkdir -p $(@D)
	$(ECHO)$(CC) $(CFLAGS) -c -o $@ $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/chacha20.c
CDEPS += $(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/chacha20.d
OBJS += $(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/chacha20.o

$(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/chachapoly.o: $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/chachapoly.c
	@$(POSIX_TOOL_PATH)echo 'Building $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/chachapoly.c'
	@$(POSIX_TOOL_PATH)mkdir -p $(@D)
	$(ECHO)$(CC) $(CFLAGS) -c -o $@ $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/chachapoly.c
CDEPS += $(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/chachapoly.d
OBJS += $(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/chachapoly.o

$(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/cipher.o: $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/cipher.c
	@$(POSIX_TOOL_PATH)echo 'Building $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/cipher.c'
	@$(POSIX_TOOL_PATH)mkdir -p $(@D)
	$(ECHO)$(CC) $(CFLAGS) -c -o $@ $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/cipher.c
CDEPS += $(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/cipher.d
OBJS += $(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/cipher.o

$(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/cipher_wrap.o: $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/cipher_wrap.c
	@$(POSIX_TOOL_PATH)echo 'Building $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/cipher_wrap.c'
	@$(POSIX_TOOL_PATH)mkdir -p $(@D)
	$(ECHO)$(CC) $(CFLAGS) -c -o $@ $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/cipher_wrap.c
CDEPS += $(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/cipher_wrap.d
OBJS += $(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/cipher_wrap.o

$(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/cmac.o: $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/cmac.c
	@$(POSIX_TOOL_PATH)echo 'Building $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/cmac.c'
	@$(POSIX_TOOL_PATH)mkdir -p $(@D)
	$(ECHO)$(CC) $(CFLAGS) -c -o $@ $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/cmac.c
CDEPS += $(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/cmac.d
OBJS += $(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/cmac.o

$(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/constant_time.o: $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/constant_time.c
	@$(POSIX_TOOL_PATH)echo 'Building $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/constant_time.c'
	@$(POSIX_TOOL_PATH)mkdir -p $(@D)
	$(ECHO)$(CC) $(CFLAGS) -c -o $@ $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/constant_time.c
CDEPS += $(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/constant_time.d
OBJS += $(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/constant_time.o

$(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/ctr_drbg.o: $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/ctr_drbg.c
	@$(POSIX_TOOL_PATH)echo 'Building $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/ctr_drbg.c'
	@$(POSIX_TOOL_PATH)mkdir -p $(@D)
	$(ECHO)$(CC) $(CFLAGS) -c -o $@ $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/ctr_drbg.c
CDEPS += $(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/ctr_drbg.d
OBJS += $(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/ctr_drbg.o

$(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/debug.o: $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/debug.c
	@$(POSIX_TOOL_PATH)echo 'Building $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/debug.c'
	@$(POSIX_TOOL_PATH)mkdir -p $(@D)
	$(ECHO)$(CC) $(CFLAGS) -c -o $@ $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/debug.c
CDEPS += $(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/debug.d
OBJS += $(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/debug.o

$(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/ecdh.o: $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/ecdh.c
	@$(POSIX_TOOL_PATH)echo 'Building $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/ecdh.c'
	@$(POSIX_TOOL_PATH)mkdir -p $(@D)
	$(ECHO)$(CC) $(CFLAGS) -c -o $@ $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/ecdh.c
CDEPS += $(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/ecdh.d
OBJS += $(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/ecdh.o

$(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/ecdsa.o: $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/ecdsa.c
	@$(POSIX_TOOL_PATH)echo 'Building $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/ecdsa.c'
	@$(POSIX_TOOL_PATH)mkdir -p $(@D)
	$(ECHO)$(CC) $(CFLAGS) -c -o $@ $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/ecdsa.c
CDEPS += $(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/ecdsa.d
OBJS += $(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/ecdsa.o

$(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/ecjpake.o: $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/ecjpake.c
	@$(POSIX_TOOL_PATH)echo 'Building $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/ecjpake.c'
	@$(POSIX_TOOL_PATH)mkdir -p $(@D)
	$(ECHO)$(CC) $(CFLAGS) -c -o $@ $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/ecjpake.c
CDEPS += $(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/ecjpake.d
OBJS += $(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/ecjpake.o

$(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/ecp.o: $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/ecp.c
	@$(POSIX_TOOL_PATH)echo 'Building $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/ecp.c'
	@$(POSIX_TOOL_PATH)mkdir -p $(@D)
	$(ECHO)$(CC) $(CFLAGS) -c -o $@ $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/ecp.c
CDEPS += $(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/ecp.d
OBJS += $(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/ecp.o

$(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/ecp_curves.o: $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/ecp_curves.c
	@$(POSIX_TOOL_PATH)echo 'Building $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/ecp_curves.c'
	@$(POSIX_TOOL_PATH)mkdir -p $(@D)
	$(ECHO)$(CC) $(CFLAGS) -c -o $@ $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/ecp_curves.c
CDEPS += $(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/ecp_curves.d
OBJS += $(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/ecp_curves.o

$(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/entropy.o: $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/entropy.c
	@$(POSIX_TOOL_PATH)echo 'Building $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/entropy.c'
	@$(POSIX_TOOL_PATH)mkdir -p $(@D)
	$(ECHO)$(CC) $(CFLAGS) -c -o $@ $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/entropy.c
CDEPS += $(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/entropy.d
OBJS += $(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/entropy.o

$(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/entropy_poll.o: $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/entropy_poll.c
	@$(POSIX_TOOL_PATH)echo 'Building $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/entropy_poll.c'
	@$(POSIX_TOOL_PATH)mkdir -p $(@D)
	$(ECHO)$(CC) $(CFLAGS) -c -o $@ $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/entropy_poll.c
CDEPS += $(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/entropy_poll.d
OBJS += $(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/entropy_poll.o

$(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/gcm.o: $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/gcm.c
	@$(POSIX_TOOL_PATH)echo 'Building $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/gcm.c'
	@$(POSIX_TOOL_PATH)mkdir -p $(@D)
	$(ECHO)$(CC) $(CFLAGS) -c -o $@ $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/gcm.c
CDEPS += $(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/gcm.d
OBJS += $(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/gcm.o

$(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/hkdf.o: $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/hkdf.c
	@$(POSIX_TOOL_PATH)echo 'Building $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/hkdf.c'
	@$(POSIX_TOOL_PATH)mkdir -p $(@D)
	$(ECHO)$(CC) $(CFLAGS) -c -o $@ $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/hkdf.c
CDEPS += $(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/hkdf.d
OBJS += $(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/hkdf.o

$(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/hmac_drbg.o: $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/hmac_drbg.c
	@$(POSIX_TOOL_PATH)echo 'Building $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/hmac_drbg.c'
	@$(POSIX_TOOL_PATH)mkdir -p $(@D)
	$(ECHO)$(CC) $(CFLAGS) -c -o $@ $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/hmac_drbg.c
CDEPS += $(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/hmac_drbg.d
OBJS += $(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/hmac_drbg.o

$(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/md.o: $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/md.c
	@$(POSIX_TOOL_PATH)echo 'Building $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/md.c'
	@$(POSIX_TOOL_PATH)mkdir -p $(@D)
	$(ECHO)$(CC) $(CFLAGS) -c -o $@ $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/md.c
CDEPS += $(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/md.d
OBJS += $(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/md.o

$(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/md5.o: $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/md5.c
	@$(POSIX_TOOL_PATH)echo 'Building $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/md5.c'
	@$(POSIX_TOOL_PATH)mkdir -p $(@D)
	$(ECHO)$(CC) $(CFLAGS) -c -o $@ $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/md5.c
CDEPS += $(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/md5.d
OBJS += $(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/md5.o

$(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/nist_kw.o: $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/nist_kw.c
	@$(POSIX_TOOL_PATH)echo 'Building $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/nist_kw.c'
	@$(POSIX_TOOL_PATH)mkdir -p $(@D)
	$(ECHO)$(CC) $(CFLAGS) -c -o $@ $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/nist_kw.c
CDEPS += $(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/nist_kw.d
OBJS += $(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/nist_kw.o

$(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/oid.o: $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/oid.c
	@$(POSIX_TOOL_PATH)echo 'Building $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/oid.c'
	@$(POSIX_TOOL_PATH)mkdir -p $(@D)
	$(ECHO)$(CC) $(CFLAGS) -c -o $@ $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/oid.c
CDEPS += $(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/oid.d
OBJS += $(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/oid.o

$(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/pem.o: $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/pem.c
	@$(POSIX_TOOL_PATH)echo 'Building $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/pem.c'
	@$(POSIX_TOOL_PATH)mkdir -p $(@D)
	$(ECHO)$(CC) $(CFLAGS) -c -o $@ $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/pem.c
CDEPS += $(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/pem.d
OBJS += $(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/pem.o

$(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/pk.o: $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/pk.c
	@$(POSIX_TOOL_PATH)echo 'Building $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/pk.c'
	@$(POSIX_TOOL_PATH)mkdir -p $(@D)
	$(ECHO)$(CC) $(CFLAGS) -c -o $@ $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/pk.c
CDEPS += $(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/pk.d
OBJS += $(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/pk.o

$(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/pk_wrap.o: $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/pk_wrap.c
	@$(POSIX_TOOL_PATH)echo 'Building $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/pk_wrap.c'
	@$(POSIX_TOOL_PATH)mkdir -p $(@D)
	$(ECHO)$(CC) $(CFLAGS) -c -o $@ $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/pk_wrap.c
CDEPS += $(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/pk_wrap.d
OBJS += $(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/pk_wrap.o

$(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/pkcs12.o: $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/pkcs12.c
	@$(POSIX_TOOL_PATH)echo 'Building $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/pkcs12.c'
	@$(POSIX_TOOL_PATH)mkdir -p $(@D)
	$(ECHO)$(CC) $(CFLAGS) -c -o $@ $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/pkcs12.c
CDEPS += $(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/pkcs12.d
OBJS += $(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/pkcs12.o

$(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/pkcs5.o: $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/pkcs5.c
	@$(POSIX_TOOL_PATH)echo 'Building $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/pkcs5.c'
	@$(POSIX_TOOL_PATH)mkdir -p $(@D)
	$(ECHO)$(CC) $(CFLAGS) -c -o $@ $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/pkcs5.c
CDEPS += $(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/pkcs5.d
OBJS += $(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/pkcs5.o

$(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/pkparse.o: $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/pkparse.c
	@$(POSIX_TOOL_PATH)echo 'Building $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/pkparse.c'
	@$(POSIX_TOOL_PATH)mkdir -p $(@D)
	$(ECHO)$(CC) $(CFLAGS) -c -o $@ $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/pkparse.c
CDEPS += $(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/pkparse.d
OBJS += $(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/pkparse.o

$(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/pkwrite.o: $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/pkwrite.c
	@$(POSIX_TOOL_PATH)echo 'Building $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/pkwrite.c'
	@$(POSIX_TOOL_PATH)mkdir -p $(@D)
	$(ECHO)$(CC) $(CFLAGS) -c -o $@ $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/pkwrite.c
CDEPS += $(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/pkwrite.d
OBJS += $(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/pkwrite.o

$(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/platform.o: $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/platform.c
	@$(POSIX_TOOL_PATH)echo 'Building $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/platform.c'
	@$(POSIX_TOOL_PATH)mkdir -p $(@D)
	$(ECHO)$(CC) $(CFLAGS) -c -o $@ $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/platform.c
CDEPS += $(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/platform.d
OBJS += $(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/platform.o

$(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/platform_util.o: $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/platform_util.c
	@$(POSIX_TOOL_PATH)echo 'Building $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/platform_util.c'
	@$(POSIX_TOOL_PATH)mkdir -p $(@D)
	$(ECHO)$(CC) $(CFLAGS) -c -o $@ $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/platform_util.c
CDEPS += $(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/platform_util.d
OBJS += $(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/platform_util.o

$(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/poly1305.o: $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/poly1305.c
	@$(POSIX_TOOL_PATH)echo 'Building $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/poly1305.c'
	@$(POSIX_TOOL_PATH)mkdir -p $(@D)
	$(ECHO)$(CC) $(CFLAGS) -c -o $@ $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/poly1305.c
CDEPS += $(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/poly1305.d
OBJS += $(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/poly1305.o

$(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/psa_crypto.o: $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/psa_crypto.c
	@$(POSIX_TOOL_PATH)echo 'Building $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/psa_crypto.c'
	@$(POSIX_TOOL_PATH)mkdir -p $(@D)
	$(ECHO)$(CC) $(CFLAGS) -c -o $@ $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/psa_crypto.c
CDEPS += $(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/psa_crypto.d
OBJS += $(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/psa_crypto.o

$(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/psa_crypto_aead.o: $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/psa_crypto_aead.c
	@$(POSIX_TOOL_PATH)echo 'Building $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/psa_crypto_aead.c'
	@$(POSIX_TOOL_PATH)mkdir -p $(@D)
	$(ECHO)$(CC) $(CFLAGS) -c -o $@ $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/psa_crypto_aead.c
CDEPS += $(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/psa_crypto_aead.d
OBJS += $(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/psa_crypto_aead.o

$(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/psa_crypto_cipher.o: $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/psa_crypto_cipher.c
	@$(POSIX_TOOL_PATH)echo 'Building $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/psa_crypto_cipher.c'
	@$(POSIX_TOOL_PATH)mkdir -p $(@D)
	$(ECHO)$(CC) $(CFLAGS) -c -o $@ $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/psa_crypto_cipher.c
CDEPS += $(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/psa_crypto_cipher.d
OBJS += $(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/psa_crypto_cipher.o

$(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/psa_crypto_client.o: $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/psa_crypto_client.c
	@$(POSIX_TOOL_PATH)echo 'Building $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/psa_crypto_client.c'
	@$(POSIX_TOOL_PATH)mkdir -p $(@D)
	$(ECHO)$(CC) $(CFLAGS) -c -o $@ $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/psa_crypto_client.c
CDEPS += $(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/psa_crypto_client.d
OBJS += $(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/psa_crypto_client.o

$(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/psa_crypto_driver_wrappers.o: $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/psa_crypto_driver_wrappers.c
	@$(POSIX_TOOL_PATH)echo 'Building $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/psa_crypto_driver_wrappers.c'
	@$(POSIX_TOOL_PATH)mkdir -p $(@D)
	$(ECHO)$(CC) $(CFLAGS) -c -o $@ $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/psa_crypto_driver_wrappers.c
CDEPS += $(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/psa_crypto_driver_wrappers.d
OBJS += $(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/psa_crypto_driver_wrappers.o

$(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/psa_crypto_ecp.o: $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/psa_crypto_ecp.c
	@$(POSIX_TOOL_PATH)echo 'Building $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/psa_crypto_ecp.c'
	@$(POSIX_TOOL_PATH)mkdir -p $(@D)
	$(ECHO)$(CC) $(CFLAGS) -c -o $@ $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/psa_crypto_ecp.c
CDEPS += $(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/psa_crypto_ecp.d
OBJS += $(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/psa_crypto_ecp.o

$(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/psa_crypto_hash.o: $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/psa_crypto_hash.c
	@$(POSIX_TOOL_PATH)echo 'Building $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/psa_crypto_hash.c'
	@$(POSIX_TOOL_PATH)mkdir -p $(@D)
	$(ECHO)$(CC) $(CFLAGS) -c -o $@ $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/psa_crypto_hash.c
CDEPS += $(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/psa_crypto_hash.d
OBJS += $(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/psa_crypto_hash.o

$(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/psa_crypto_mac.o: $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/psa_crypto_mac.c
	@$(POSIX_TOOL_PATH)echo 'Building $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/psa_crypto_mac.c'
	@$(POSIX_TOOL_PATH)mkdir -p $(@D)
	$(ECHO)$(CC) $(CFLAGS) -c -o $@ $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/psa_crypto_mac.c
CDEPS += $(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/psa_crypto_mac.d
OBJS += $(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/psa_crypto_mac.o

$(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/psa_crypto_rsa.o: $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/psa_crypto_rsa.c
	@$(POSIX_TOOL_PATH)echo 'Building $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/psa_crypto_rsa.c'
	@$(POSIX_TOOL_PATH)mkdir -p $(@D)
	$(ECHO)$(CC) $(CFLAGS) -c -o $@ $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/psa_crypto_rsa.c
CDEPS += $(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/psa_crypto_rsa.d
OBJS += $(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/psa_crypto_rsa.o

$(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/psa_crypto_se.o: $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/psa_crypto_se.c
	@$(POSIX_TOOL_PATH)echo 'Building $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/psa_crypto_se.c'
	@$(POSIX_TOOL_PATH)mkdir -p $(@D)
	$(ECHO)$(CC) $(CFLAGS) -c -o $@ $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/psa_crypto_se.c
CDEPS += $(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/psa_crypto_se.d
OBJS += $(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/psa_crypto_se.o

$(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/psa_crypto_slot_management.o: $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/psa_crypto_slot_management.c
	@$(POSIX_TOOL_PATH)echo 'Building $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/psa_crypto_slot_management.c'
	@$(POSIX_TOOL_PATH)mkdir -p $(@D)
	$(ECHO)$(CC) $(CFLAGS) -c -o $@ $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/psa_crypto_slot_management.c
CDEPS += $(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/psa_crypto_slot_management.d
OBJS += $(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/psa_crypto_slot_management.o

$(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/psa_crypto_storage.o: $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/psa_crypto_storage.c
	@$(POSIX_TOOL_PATH)echo 'Building $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/psa_crypto_storage.c'
	@$(POSIX_TOOL_PATH)mkdir -p $(@D)
	$(ECHO)$(CC) $(CFLAGS) -c -o $@ $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/psa_crypto_storage.c
CDEPS += $(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/psa_crypto_storage.d
OBJS += $(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/psa_crypto_storage.o

$(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/psa_its_file.o: $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/psa_its_file.c
	@$(POSIX_TOOL_PATH)echo 'Building $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/psa_its_file.c'
	@$(POSIX_TOOL_PATH)mkdir -p $(@D)
	$(ECHO)$(CC) $(CFLAGS) -c -o $@ $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/psa_its_file.c
CDEPS += $(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/psa_its_file.d
OBJS += $(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/psa_its_file.o

$(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/rsa.o: $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/rsa.c
	@$(POSIX_TOOL_PATH)echo 'Building $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/rsa.c'
	@$(POSIX_TOOL_PATH)mkdir -p $(@D)
	$(ECHO)$(CC) $(CFLAGS) -c -o $@ $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/rsa.c
CDEPS += $(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/rsa.d
OBJS += $(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/rsa.o

$(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/rsa_alt_helpers.o: $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/rsa_alt_helpers.c
	@$(POSIX_TOOL_PATH)echo 'Building $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/rsa_alt_helpers.c'
	@$(POSIX_TOOL_PATH)mkdir -p $(@D)
	$(ECHO)$(CC) $(CFLAGS) -c -o $@ $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/rsa_alt_helpers.c
CDEPS += $(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/rsa_alt_helpers.d
OBJS += $(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/rsa_alt_helpers.o

$(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/sha1.o: $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/sha1.c
	@$(POSIX_TOOL_PATH)echo 'Building $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/sha1.c'
	@$(POSIX_TOOL_PATH)mkdir -p $(@D)
	$(ECHO)$(CC) $(CFLAGS) -c -o $@ $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/sha1.c
CDEPS += $(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/sha1.d
OBJS += $(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/sha1.o

$(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/sha256.o: $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/sha256.c
	@$(POSIX_TOOL_PATH)echo 'Building $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/sha256.c'
	@$(POSIX_TOOL_PATH)mkdir -p $(@D)
	$(ECHO)$(CC) $(CFLAGS) -c -o $@ $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/sha256.c
CDEPS += $(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/sha256.d
OBJS += $(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/sha256.o

$(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/sha512.o: $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/sha512.c
	@$(POSIX_TOOL_PATH)echo 'Building $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/sha512.c'
	@$(POSIX_TOOL_PATH)mkdir -p $(@D)
	$(ECHO)$(CC) $(CFLAGS) -c -o $@ $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/sha512.c
CDEPS += $(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/sha512.d
OBJS += $(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/sha512.o

$(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/ssl_cache.o: $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/ssl_cache.c
	@$(POSIX_TOOL_PATH)echo 'Building $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/ssl_cache.c'
	@$(POSIX_TOOL_PATH)mkdir -p $(@D)
	$(ECHO)$(CC) $(CFLAGS) -c -o $@ $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/ssl_cache.c
CDEPS += $(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/ssl_cache.d
OBJS += $(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/ssl_cache.o

$(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/ssl_ciphersuites.o: $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/ssl_ciphersuites.c
	@$(POSIX_TOOL_PATH)echo 'Building $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/ssl_ciphersuites.c'
	@$(POSIX_TOOL_PATH)mkdir -p $(@D)
	$(ECHO)$(CC) $(CFLAGS) -c -o $@ $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/ssl_ciphersuites.c
CDEPS += $(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/ssl_ciphersuites.d
OBJS += $(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/ssl_ciphersuites.o

$(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/ssl_client.o: $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/ssl_client.c
	@$(POSIX_TOOL_PATH)echo 'Building $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/ssl_client.c'
	@$(POSIX_TOOL_PATH)mkdir -p $(@D)
	$(ECHO)$(CC) $(CFLAGS) -c -o $@ $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/ssl_client.c
CDEPS += $(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/ssl_client.d
OBJS += $(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/ssl_client.o

$(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/ssl_cookie.o: $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/ssl_cookie.c
	@$(POSIX_TOOL_PATH)echo 'Building $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/ssl_cookie.c'
	@$(POSIX_TOOL_PATH)mkdir -p $(@D)
	$(ECHO)$(CC) $(CFLAGS) -c -o $@ $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/ssl_cookie.c
CDEPS += $(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/ssl_cookie.d
OBJS += $(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/ssl_cookie.o

$(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/ssl_debug_helpers_generated.o: $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/ssl_debug_helpers_generated.c
	@$(POSIX_TOOL_PATH)echo 'Building $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/ssl_debug_helpers_generated.c'
	@$(POSIX_TOOL_PATH)mkdir -p $(@D)
	$(ECHO)$(CC) $(CFLAGS) -c -o $@ $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/ssl_debug_helpers_generated.c
CDEPS += $(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/ssl_debug_helpers_generated.d
OBJS += $(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/ssl_debug_helpers_generated.o

$(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/ssl_msg.o: $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/ssl_msg.c
	@$(POSIX_TOOL_PATH)echo 'Building $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/ssl_msg.c'
	@$(POSIX_TOOL_PATH)mkdir -p $(@D)
	$(ECHO)$(CC) $(CFLAGS) -c -o $@ $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/ssl_msg.c
CDEPS += $(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/ssl_msg.d
OBJS += $(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/ssl_msg.o

$(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/ssl_ticket.o: $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/ssl_ticket.c
	@$(POSIX_TOOL_PATH)echo 'Building $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/ssl_ticket.c'
	@$(POSIX_TOOL_PATH)mkdir -p $(@D)
	$(ECHO)$(CC) $(CFLAGS) -c -o $@ $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/ssl_ticket.c
CDEPS += $(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/ssl_ticket.d
OBJS += $(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/ssl_ticket.o

$(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/ssl_tls.o: $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/ssl_tls.c
	@$(POSIX_TOOL_PATH)echo 'Building $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/ssl_tls.c'
	@$(POSIX_TOOL_PATH)mkdir -p $(@D)
	$(ECHO)$(CC) $(CFLAGS) -c -o $@ $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/ssl_tls.c
CDEPS += $(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/ssl_tls.d
OBJS += $(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/ssl_tls.o

$(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/ssl_tls12_client.o: $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/ssl_tls12_client.c
	@$(POSIX_TOOL_PATH)echo 'Building $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/ssl_tls12_client.c'
	@$(POSIX_TOOL_PATH)mkdir -p $(@D)
	$(ECHO)$(CC) $(CFLAGS) -c -o $@ $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/ssl_tls12_client.c
CDEPS += $(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/ssl_tls12_client.d
OBJS += $(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/ssl_tls12_client.o

$(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/ssl_tls12_server.o: $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/ssl_tls12_server.c
	@$(POSIX_TOOL_PATH)echo 'Building $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/ssl_tls12_server.c'
	@$(POSIX_TOOL_PATH)mkdir -p $(@D)
	$(ECHO)$(CC) $(CFLAGS) -c -o $@ $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/ssl_tls12_server.c
CDEPS += $(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/ssl_tls12_server.d
OBJS += $(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/ssl_tls12_server.o

$(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/threading.o: $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/threading.c
	@$(POSIX_TOOL_PATH)echo 'Building $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/threading.c'
	@$(POSIX_TOOL_PATH)mkdir -p $(@D)
	$(ECHO)$(CC) $(CFLAGS) -c -o $@ $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/threading.c
CDEPS += $(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/threading.d
OBJS += $(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/threading.o

$(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/version.o: $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/version.c
	@$(POSIX_TOOL_PATH)echo 'Building $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/version.c'
	@$(POSIX_TOOL_PATH)mkdir -p $(@D)
	$(ECHO)$(CC) $(CFLAGS) -c -o $@ $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/version.c
CDEPS += $(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/version.d
OBJS += $(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/version.o

$(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/x509.o: $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/x509.c
	@$(POSIX_TOOL_PATH)echo 'Building $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/x509.c'
	@$(POSIX_TOOL_PATH)mkdir -p $(@D)
	$(ECHO)$(CC) $(CFLAGS) -c -o $@ $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/x509.c
CDEPS += $(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/x509.d
OBJS += $(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/x509.o

$(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/x509_create.o: $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/x509_create.c
	@$(POSIX_TOOL_PATH)echo 'Building $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/x509_create.c'
	@$(POSIX_TOOL_PATH)mkdir -p $(@D)
	$(ECHO)$(CC) $(CFLAGS) -c -o $@ $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/x509_create.c
CDEPS += $(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/x509_create.d
OBJS += $(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/x509_create.o

$(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/x509_crl.o: $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/x509_crl.c
	@$(POSIX_TOOL_PATH)echo 'Building $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/x509_crl.c'
	@$(POSIX_TOOL_PATH)mkdir -p $(@D)
	$(ECHO)$(CC) $(CFLAGS) -c -o $@ $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/x509_crl.c
CDEPS += $(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/x509_crl.d
OBJS += $(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/x509_crl.o

$(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/x509_crt.o: $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/x509_crt.c
	@$(POSIX_TOOL_PATH)echo 'Building $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/x509_crt.c'
	@$(POSIX_TOOL_PATH)mkdir -p $(@D)
	$(ECHO)$(CC) $(CFLAGS) -c -o $@ $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/x509_crt.c
CDEPS += $(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/x509_crt.d
OBJS += $(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/x509_crt.o

$(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/x509_csr.o: $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/x509_csr.c
	@$(POSIX_TOOL_PATH)echo 'Building $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/x509_csr.c'
	@$(POSIX_TOOL_PATH)mkdir -p $(@D)
	$(ECHO)$(CC) $(CFLAGS) -c -o $@ $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/x509_csr.c
CDEPS += $(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/x509_csr.d
OBJS += $(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/x509_csr.o

$(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/x509write_crt.o: $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/x509write_crt.c
	@$(POSIX_TOOL_PATH)echo 'Building $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/x509write_crt.c'
	@$(POSIX_TOOL_PATH)mkdir -p $(@D)
	$(ECHO)$(CC) $(CFLAGS) -c -o $@ $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/x509write_crt.c
CDEPS += $(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/x509write_crt.d
OBJS += $(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/x509write_crt.o

$(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/x509write_csr.o: $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/x509write_csr.c
	@$(POSIX_TOOL_PATH)echo 'Building $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/x509write_csr.c'
	@$(POSIX_TOOL_PATH)mkdir -p $(@D)
	$(ECHO)$(CC) $(CFLAGS) -c -o $@ $(COPIED_SDK_PATH)/util/third_party/mbedtls/library/x509write_csr.c
CDEPS += $(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/x509write_csr.d
OBJS += $(OUTPUT_DIR)/sdk/util/third_party/mbedtls/library/x509write_csr.o

# Automatically-generated Simplicity Studio Metadata
# Please do not edit or delete these lines!
# SIMPLICITY_STUDIO_METADATA=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END_SIMPLICITY_STUDIO_METADATA
# END OF METADATA