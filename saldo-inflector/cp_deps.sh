echo 'Copying dynamic library'

cp $(stack path --local-install-root)/lib/libsaldo.* lib/

if [ "$(uname)" = "Linux" ]; then

	echo 'Fishing out dependencies for linux'

	mkdir -p lib/ext_libs

	ldd lib/libsaldo.so |grep ' => ' |grep 'libHS' |cut -d '>' -f2 |cut -d '(' -f1 | while read file
		do
			cp $file lib/ext_libs/
		done
	echo 'Editing rpath such that the main libsaldo.so can find its Haskell deps'

	chrpath -r '$ORIGIN/ext_libs' lib/libsaldo.so
fi
