#!/bin/bash
set -ex

# Install build-essential and unzip
sudo apt-get install build-essential unzip

# Install NDK
wget https://dl.google.com/android/repository/android-ndk-r21e-linux-x86_64.zip
unzip android-ndk-r21e-linux-x86_64.zip
export NDK=$PWD/android-ndk-r21e
export TOOLCHAIN=$NDK/toolchains/llvm/prebuilt/linux-x86_64

# Clone icu
git clone https://github.com/unicode-org/icu.git
export ICU_SOURCE=$PWD/icu

# Prepare output folder
mkdir build -p
export OUTPUT=$PWD/build

# Build ICU for host
mkdir build-host -p
pushd build-host
#	../build-host.sh
popd
export HOST_BUILD=$PWD/build-host

targets=(aarch64-linux-android)
for target in ${targets[*]}
do
    # Build ICU for Android $target
    export TARGET=$target
	mkdir build-$target -p
	pushd build-$target
		../build-target.sh 
	popd
done
