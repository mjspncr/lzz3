#!/usr/bin/env bash

# Define some vars to be used on makefiles
export CONFIG=gcc
export LZZ="$(pwd)/lzz"
export INCDIRS="$(pwd)/lua-5.3.0"
export MORELIBDIRS="$(pwd)/lua-5.3.0"
export BASILCC_ROOT="$(pwd)/basilcc/build.$CONFIG/"
export BASILCC_LIB=$BASILCC_ROOT/lib
export BASILCC_SRC=$BASILCC_ROOT/src


if [ ! -d "lua-5.3.0" ] 
then
	# Compile lua 5.3 requirement
	wget https://github.com/lua/lua/archive/v5.3.0.tar.gz
	tar -xf v5.3.0.tar.gz
	cd lua-5.3.0
	echo -e 'extern "C" {\n#include "lua.h"\n#include "lualib.h"\n#include "lualib.h"\n#include "lauxlib.h"\n}' > lua.hpp # Create missing cpp lua header
	make -j
	ar -qc liblua.a *.o # Create static liblua
	cd ../
	rm v5.3.0.tar.gz
fi

if [ ! -d "basilcc" ] 
then
	# Compile basilcc requirement
	git clone https://github.com/mjspncr/basilcc
	cd basilcc
	make -j
	cd ../
fi

# Compile lzz
mkdir -p build.$CONFIG/src build.$CONFIG/lib
cp lua-5.3.0/*.h build.$CONFIG/src/
cp lua-5.3.0/*.hpp build.$CONFIG/src/
cp lua-5.3.0/liblua.a build.$CONFIG/lib/
make -j
cp build.$CONFIG/bin/lzz3 $(pwd)/lzz3
echo "Done! Enjoy your lzz3 at $(pwd)/lzz3"
