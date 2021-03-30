#!/bin/bash
set -ex

# Install build-essential and unzip
sudo apt-get install build-essential unzip

# Install NDK
wget https://dl.google.com/android/repository/android-ndk-r21e-linux-x86_64.zip
unzip android-ndk-r21e-linux-x86_64.zip
export NDK=$PWD/android-ndk-r21e

# Clone icu
git clone https://github.com/unicode-org/icu.git
export ICU_SOURCE=$PWD/icu

# Build ICU for host
mkdir build-host
pushd build-host
	$ICU_SOURCE/icu4c/source/configure
	make -j8
popd
export HOST_BUILD=$PWD/build-host

# Build ICU for Android aarch64
mkdir build-aarch64-linux-android
pushd build-aarch64-linux-android
	export TOOLCHAIN=$NDK/toolchains/llvm/prebuilt/linux-x86_64
	export TARGET=aarch64-linux-android
	export API=21
	export AR=$TOOLCHAIN/bin/llvm-ar
	export CC=$TOOLCHAIN/bin/$TARGET$API-clang
	export AS=$CC
	export CXX=$TOOLCHAIN/bin/$TARGET$API-clang++
	export LD=$TOOLCHAIN/bin/ld
	export RANLIB=$TOOLCHAIN/bin/llvm-ranlib
	export STRIP=$TOOLCHAIN/bin/llvm-strip
	$ICU_SOURCE/icu4c/source/configure --host $TARGET --with-cross-build=$HOST_BUILD --enable-static=yes --enable-shared=yes
	make -j8
popd
