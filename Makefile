all: capp

saldolib: src/Saldo.hs package.yaml stack.yaml
	rm saldo.cabal
	stack build
	cp $(shell dirname $(shell stack exec -- which saldo-exe))/../lib/libsaldo.* capp

capp: saldolib
	cd capp && make

run: capp
	cd capp && make run

clean:
	rm -f saldo.cabal
	rm -rf dist-newstyle
	stack clean && cd capp && make clean

.PHONY: all usingcabal potatolib capp run clean
