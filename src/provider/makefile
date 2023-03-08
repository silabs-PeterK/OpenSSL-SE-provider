CC=gcc
CFLAGS=-fPIC -g
LDFLAGS = -shared

#sudo gcc test.c -lssl -lcrypto -I

SDK_PATH ?= $(GSDK_REPO)
OPENSSLDIR= /usr/local/src/openssl-3.0.7
#OPENSSLDIR= /home/peter/openssl-3.0.8
LIBSDIR= /usr/lib/
PROVIDERSDIR=/usr/local/ssl/lib/ossl-modules/

INCLUDES += \
  -I ../../inc/ \
  -I $(SDK_PATH)/platform/security/sl_component/sl_psa_driver/inc/ \
  -I $(SDK_PATH)/util/third_party/mbedtls/include/ \
  -I $(SDK_PATH)/platform/common/inc/ \
  -I usr/local/ssl/lib/ossl-modules/ \
  -I $(OPENSSLDIR)/include/ \
  -I $(OPENSSLDIR)/providers/common/include/ \
  -I $(OPENSSLDIR)/providers/implementations/include/ \
  -I $(SDK_PATH)/platform/security/sl_component/sl_cpc_secure_engine/common/inc \
  -I $(SDK_PATH)/platform/security/sl_component/sl_cpc_secure_engine/primary/inc \
  -I $(SDK_PATH)/platform/security/sl_component/se_manager/inc \
  -I $(SDK_PATH)/platform/emlib/inc \
  -I $(SDK_PATH)/platform/emlib/host/inc 

LIBS += \
  $(SDK_PATH)/platform/security/sl_component/sl_secure_engine_cpc/build/debug/primary_psa_lib.a \
  $(OPENSSLDIR)/providers/libcommon.a \
  -lcrypto \
  -lssl \
  -lcpc 

TARGET=libpsaprov.so
SOURCES = \
	psaprovider.c

OBJECTS = \
  libpsaprov.o


all: $(TARGET)
	   @true

 $(OBJECTS) : $(SOURCES)
	@echo "============="
	@echo "Compiling $<" 
	@$(CC) $(CFLAGS) -o  $(OBJECTS) -c  $(SOURCES) $(INCLUDES)

$(TARGET): $(OBJECTS)
	@echo "======================="
	@echo "Creating engine library $@"
	@echo "======================="
	@$(CC)  $(LDFLAGS) -o $(TARGET)  $(OBJECTS) $(LIBS) 
	@echo "-- $@ created --"
	@sudo ln $(addprefix $(CURDIR)/, $(TARGET)) $(addprefix $(LIBSDIR), $(TARGET))
	@sudo ln $(addprefix $(CURDIR)/, $(TARGET)) $(addprefix $(PROVIDERSDIR), $(TARGET))
.PHONY : clean

clean:
	@find ./ -type f -name '*.o' -exec rm -v {} \;
	@sudo rm $(addprefix $(CURDIR)/, $(TARGET))
	@sudo rm $(addprefix $(LIBSDIR), $(TARGET))
	@sudo rm $(addprefix $(PROVIDERSDIR), $(TARGET))

