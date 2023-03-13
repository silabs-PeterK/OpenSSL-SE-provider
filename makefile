SDK_PATH ?= $(GSDK_REPO)

all:
	(cd $(SDK_PATH)/platform/security/sl_component/sl_secure_engine_cpc; make clean; make -f primary_psa_lib.Makefile)
	(cd provider; make clean; make )
	(cd tests; make clean; make )

clean:
	(cd provider; make clean)
	(cd tests; make clean)