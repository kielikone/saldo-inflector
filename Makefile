all: lib

lib: src/Saldo.hs package.yaml stack.yaml
	rm saldo.cabal
	stack build
	mkdir lib
	bash cp_deps.sh

clean:
	rm -rf lib
	rm -f saldo.cabal
	rm -rf dist-newstyle
	stack clean

.PHONY: all clean
