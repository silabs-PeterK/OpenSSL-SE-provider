# OpenSSL-SE-provider

1.) install OpenSSL 3.0

2.) set OPENSSLDIR, LIBSDIR and PROVIDERSDIR in makefiles (for now, I will redo it to be more central later)

3.) cd OpenSSL-2-PSA

4.) make

5.) ./tests/a.out or set the config file to use the provider and run whatever test you like with openssl (how to will be added later).
