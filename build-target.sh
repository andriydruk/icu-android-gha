#!/bin/bash
set -ex
	
# Setup toolchain for current target	
export API=21
export AR=$TOOLCHAIN/bin/llvm-ar
export CC=$TOOLCHAIN/bin/$TARGET$API-clang
export AS=$CC
export CXX=$TOOLCHAIN/bin/$TARGET$API-clang++
export LD=$TOOLCHAIN/bin/ld
export RANLIB=$TOOLCHAIN/bin/llvm-ranlib
export STRIP=$TOOLCHAIN/bin/llvm-strip

# Build ICU for current target
$ICU_SOURCE/icu4c/source/configure --host $TARGET --with-cross-build=$HOST_BUILD --enable-static=yes --enable-shared=yes
make -j8
