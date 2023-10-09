echo 'Copying dynamic library'

cp $(dirname $(stack exec -- which saldo-exe))/../lib/libsaldo.* lib/

if [ "$(uname)" = "Linux" ]; then

	echo "Fishing out dependencies for linux"

	mkdir -p lib/ext_libs

	ldd lib/libsaldo.so |grep ' => ' |cut -d '>' -f2 |cut -d '(' -f1 | while read file
		do
			cp $file lib/ext_libs/
		done
fi
