CC=gcc
CFLAGS=-fPIC -g
LDFLAGS = -shared -g

OPENSSLDIR=/usr/local/src/openssl-3.0.7/
ENGINESDIR=/usr/local/ssl/lib/engines-3/
PSACRYPTOINCDIR=../../artifact/gecko_sdk_4.2.0/util/third_party/mbedtls/include/
SLDINCIR=../../artifact/gecko_sdk_4.2.0/platform/security/sl_component/sl_psa_driver/inc/
#sudo gcc test.c -lssl -lcrypto -I

TARGETLIB=libpsaengine.so
TARGETENGINE=psaengine.so
SOURCES = \
	compile.c 
PSAOBJECTS = \
	../../artifact/build/debug/primary.a
OBJECTS = \
	libpsaengine.o
LIBSDIR= \
	/usr/lib/

all: $(TARGETLIB)
	   @true

 $(OBJECTS) : $(SOURCES)
	@echo "============="
	@echo "Compiling $<"
	@$(CC) $(CFLAGS) -o  $(OBJECTS) -c  $(SOURCES) -I ../../inc/ -I $(SLDINCIR) -I $(PSACRYPTOINCDIR) -I /implementations/ -I $(OPENSSLDIR)include/ -I $(OPENSSLDIR)/engines/

$(TARGETLIB): $(OBJECTS)
	@echo "======================="
	@echo "Creating engine library $@"
	@echo "======================="
	@$(CC)  $(LDFLAGS) -o $(TARGETLIB)  $(OBJECTS) $(PSAOBJECTS) -lcrypto -lssl
	@echo "-- $@ created --"
	@sudo ln $(addprefix $(CURDIR)/, $(TARGETLIB)) $(addprefix $(LIBSDIR), $(TARGETENGINE))
	@sudo ln $(addprefix $(CURDIR)/, $(TARGETLIB)) $(addprefix $(ENGINESDIR), $(TARGETENGINE))
.PHONY : clean

clean:
	@find ./ -type f -name '*.o' -exec rm -v {} \;
	@sudo rm $(addprefix $(CURDIR)/, $(TARGETLIB))
	@sudo rm $(addprefix $(LIBSDIR), $(TARGETENGINE))
	@sudo rm $(addprefix $(ENGINESDIR), $(TARGETENGINE))

