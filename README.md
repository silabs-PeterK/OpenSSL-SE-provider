# OpenSSL-SE-provider

1.) Install cpc deamon

2.) Flash and run the app on the board

3.) Iinstall OpenSSL 3.0

4.) Download GSDK for example to /home/cpc/OpenSSL-2-PSA/artifact/

5.) Set GSDK_REPO, OPENSSLDIR, LIBSDIR and PROVIDERSDIR environment variables:
export GSDK_REPO=/home/cpc/OpenSSL-2-PSA/artifact/gecko_sdk_4.2.0/
export OPENSSL_DIR=/usr/local/src/openssl-3.0.7
export LIBS_DIR=/usr/lib/
export PROVIDERS_DIR=/usr/local/ssl/lib/ossl-modules/

6.) Run cpc deamon:
cd cpc-daemon/build
sudo ./cpcd -c ../cpcd_spi.conf

7.) Go to OpenSSL-2-PSA directory:
cd OpenSSL-2-PSA

8.) Make the project:
make

9.) Run developer tests:
./tests/a.out 

or 
9.) Set the config file to use the provider and run whatever test you like with openssl:
cd $OPENSSL_DIR/test
OPENSSL_CONF=/home/cpc/OpenSSL-2-PSA/openssl_psa_prov.cnf ../util/shlib_wrap.sh ./aesgcmtest
OPENSSL_CONF=/home/cpc/OpenSSL-2-PSA/openssl_psa_prov.cnf ../util/shlib_wrap.sh ./sha_test


