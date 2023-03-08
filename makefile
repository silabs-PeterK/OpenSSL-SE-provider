all:
	(cd artifact; make clean; make -f primary_psa_lib.Makefile)
	(cd src/provider; make clean; make )
	(cd src/engine; make clean; make )
	(cd tests; make clean; make )

clean:
	(cd src/provider; make clean)
	(cd src/engine; make clean)
	(cd src; make clean)
	(cd tests; make clean)