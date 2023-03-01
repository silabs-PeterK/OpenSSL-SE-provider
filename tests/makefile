CC=gcc

OPENSSLDIR=/usr/local/src/openssl-3.0.7/include
PSACRYPTOINCDIR=../artifact/gecko_sdk_4.2.0/util/third_party/mbedtls/include/
SLDINCIR=../artifact/gecko_sdk_4.2.0/platform/security/sl_component/sl_psa_driver/inc/
all:
	@echo "============="
	@echo "Compiling $<"
	@$(CC) -g test.c -I $(OPENSSLDIR) -I $(SLDINCIR) -I $(PSACRYPTOINCDIR) -lcrypto -lpsaprov -lpsaengine

.PHONY : clean

clean:
	@find ./ -type f -name '*.out' -exec rm -v {} \;
