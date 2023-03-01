####################################################################
# Automatically-generated file. Do not edit!                       #
# Makefile Version 14                                              #
####################################################################

BASE_SDK_PATH = /Users/halindst/Desktop/gsdk
UNAME:=$(shell $(POSIX_TOOL_PATH)uname -s | $(POSIX_TOOL_PATH)sed -e 's/^\(CYGWIN\).*/\1/' | $(POSIX_TOOL_PATH)sed -e 's/^\(MINGW\).*/\1/')
ifeq ($(UNAME),MINGW)
# Translate "C:/super" into "/C/super" for MinGW make.
SDK_PATH := /$(shell $(POSIX_TOOL_PATH)echo $(BASE_SDK_PATH) | sed s/://)
endif
SDK_PATH ?= $(BASE_SDK_PATH)
COPIED_SDK_PATH ?= gecko_sdk_4.2.0

# This uses the explicit build rules below
PROJECT_SOURCE_FILES =

C_SOURCE_FILES   += $(filter %.c, $(PROJECT_SOURCE_FILES))
CXX_SOURCE_FILES += $(filter %.cpp, $(PROJECT_SOURCE_FILES))
CXX_SOURCE_FILES += $(filter %.cc, $(PROJECT_SOURCE_FILES))
ASM_SOURCE_FILES += $(filter %.s, $(PROJECT_SOURCE_FILES))
ASM_SOURCE_FILES += $(filter %.S, $(PROJECT_SOURCE_FILES))
LIB_FILES        += $(filter %.a, $(PROJECT_SOURCE_FILES))

C_DEFS += \
 '-DSLI_SE_MAJOR_VERSION_TWO=1' \
 '-DSL_MBEDTLS_NO_CRYPTO_ACCELERATION=1' \
 '-DSL_COMPONENT_CATALOG_PRESENT=1' \
 '-DMBEDTLS_CONFIG_FILE=<sl_mbedtls_config.h>' \
 '-DSLI_MBEDTLS_CONFIG_AUTOGEN_OVERRIDE_FILE=<sli_mbedtls_config_host.h>' \
 '-DMBEDTLS_PSA_CRYPTO_CONFIG_FILE=<sl_psa_config.h>' \
 '-DSLI_PSA_CONFIG_AUTOGEN_OVERRIDE_FILE=<sli_psa_config_host.h>'

ASM_DEFS += \
 '-DSLI_SE_MAJOR_VERSION_TWO=1' \
 '-DSL_MBEDTLS_NO_CRYPTO_ACCELERATION=1' \
 '-DSL_COMPONENT_CATALOG_PRESENT=1' \
 '-DMBEDTLS_CONFIG_FILE=<sl_mbedtls_config.h>' \
 '-DSLI_MBEDTLS_CONFIG_AUTOGEN_OVERRIDE_FILE=<sli_mbedtls_config_host.h>' \
 '-DMBEDTLS_PSA_CRYPTO_CONFIG_FILE=<sl_psa_config.h>' \
 '-DSLI_PSA_CONFIG_AUTOGEN_OVERRIDE_FILE=<sli_psa_config_host.h>'

INCLUDES += \
 -Iconfig \
 -Iautogen \
 -I$(COPIED_SDK_PATH)/platform/CMSIS/Core/Include \
 -I$(COPIED_SDK_PATH)/platform/security/sl_component/sl_cpc_secure_engine/common/inc \
 -I$(COPIED_SDK_PATH)/platform/security/sl_component/sl_cpc_secure_engine/primary/inc \
 -I$(COPIED_SDK_PATH)/platform/emlib/inc \
 -I$(COPIED_SDK_PATH)/platform/emlib/host/inc \
 -I$(COPIED_SDK_PATH)/platform/security/sl_component/sl_mbedtls_support/config \
 -I$(COPIED_SDK_PATH)/platform/security/sl_component/sl_mbedtls_support/config/preset \
 -I$(COPIED_SDK_PATH)/util/third_party/mbedtls/include \
 -I$(COPIED_SDK_PATH)/util/third_party/mbedtls/library \
 -I$(COPIED_SDK_PATH)/platform/security/sl_component/sl_mbedtls_support/inc \
 -I$(COPIED_SDK_PATH)/platform/security/sl_component/sl_psa_driver/inc/public \
 -I$(COPIED_SDK_PATH)/platform/security/sl_component/sl_psa_driver/inc \
 -I$(COPIED_SDK_PATH)/platform/security/sl_component/se_manager/inc \
 -I$(COPIED_SDK_PATH)/platform/security/sl_component/se_manager/src \
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

$(OUTPUT_DIR)/sdk/platform/security/sl_component/sl_cpc_secure_engine/primary/src/sl_cpc_se_primary.o: $(COPIED_SDK_PATH)/platform/security/sl_component/sl_cpc_secure_engine/primary/src/sl_cpc_se_primary.c
	@$(POSIX_TOOL_PATH)echo 'Building $(COPIED_SDK_PATH)/platform/security/sl_component/sl_cpc_secure_engine/primary/src/sl_cpc_se_primary.c'
	@$(POSIX_TOOL_PATH)mkdir -p $(@D)
	$(ECHO)$(CC) $(CFLAGS) -c -o $@ $(COPIED_SDK_PATH)/platform/security/sl_component/sl_cpc_secure_engine/primary/src/sl_cpc_se_primary.c
CDEPS += $(OUTPUT_DIR)/sdk/platform/security/sl_component/sl_cpc_secure_engine/primary/src/sl_cpc_se_primary.d
OBJS += $(OUTPUT_DIR)/sdk/platform/security/sl_component/sl_cpc_secure_engine/primary/src/sl_cpc_se_primary.o

$(OUTPUT_DIR)/sdk/platform/security/sl_component/sl_mbedtls_support/src/error.o: $(COPIED_SDK_PATH)/platform/security/sl_component/sl_mbedtls_support/src/error.c
	@$(POSIX_TOOL_PATH)echo 'Building $(COPIED_SDK_PATH)/platform/security/sl_component/sl_mbedtls_support/src/error.c'
	@$(POSIX_TOOL_PATH)mkdir -p $(@D)
	$(ECHO)$(CC) $(CFLAGS) -c -o $@ $(COPIED_SDK_PATH)/platform/security/sl_component/sl_mbedtls_support/src/error.c
CDEPS += $(OUTPUT_DIR)/sdk/platform/security/sl_component/sl_mbedtls_support/src/error.d
OBJS += $(OUTPUT_DIR)/sdk/platform/security/sl_component/sl_mbedtls_support/src/error.o

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