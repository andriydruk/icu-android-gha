#!/bin/bash
set -ex

# Build ICU for host
$ICU_SOURCE/icu4c/source/configure
make -j8
