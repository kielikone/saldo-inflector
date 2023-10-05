all:
ifeq ($(UNAME), Linux)
	clang++ -g -Wall saldomain.cpp -o $@ \
	-I../csrc \
	-stdlib=libc++
	-Wl,-rpath='$$ORIGIN' \
	-lsaldo \
	-L./
else
	g++ -g -Wall saldomain.cpp -o $@ \
	-I../csrc \
	-lsaldo \
	-L./

	install_name_tool -add_rpath @executable_path/. all

endif
# set rpath path on mac, see https://medium.com/@donblas/fun-with-rpath-otool-and-install-name-tool-e3e41ae86172
#ifeq ($(UNAME), Darwin)
#endif
clean:
	rm all
	rm -rf all.dSYM
