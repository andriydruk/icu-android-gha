#!/bin/bash
set -ex
	
# Setup toolchain for current target	
export API=23
export AR=$TOOLCHAIN/bin/llvm-ar
export CC=$TOOLCHAIN/bin/$TARGET$API-clang
export AS=$CC
export CXX=$TOOLCHAIN/bin/$TARGET$API-clang++
export LD=$TOOLCHAIN/bin/ld
export RANLIB=$TOOLCHAIN/bin/llvm-ranlib
export STRIP=$TOOLCHAIN/bin/llvm-strip
export CFLAGS="-D_REENTRANT -O3 -DPIC -fPIC -Wall -Werror -Wno-missing-field-initializers -Wno-sign-compare -Wno-unreachable-code-loop-increment"
export CXXFLAGS="-std=c++11 -frtti"

make clean

# Build ICU for current target
$ICU_SOURCE/icu4c/source/configure --host $TARGET \
	--with-cross-build=$HOST_BUILD \
	--enable-static=yes \
	--enable-shared=yes \
	--prefix=$OUTPUT/$TARGET \
	--disable-rename

make -j8
make tests
make install
