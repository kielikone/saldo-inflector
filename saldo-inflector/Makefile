UNAME := $(shell uname)

all: lib

lib: src/Saldo.hs stack.yaml
	rm -f saldo.cabal
ifeq ($(UNAME), Linux) # Pass different linker flags
	cp package.yaml.linux package.yaml	
endif
ifeq ($(UNAME), Darwin)
	cp package.yaml.macos package.yaml
endif
	stack build
	mkdir lib
	bash cp_deps.sh

clean:
ifeq ($(UNAME), Linux) # Pass different linker flags
	cp package.yaml.linux package.yaml	
endif
ifeq ($(UNAME), Darwin)
	cp package.yaml.macos package.yaml
endif
	rm -rf lib
	rm -f saldo.cabal
	rm -rf dist-newstyle
	stack clean
	rm -f package.yaml

.PHONY: all clean
