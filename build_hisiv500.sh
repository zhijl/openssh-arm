#!/usr/bin/env bash

set -eu

# config project path and install path
PROJECT_PATH=`pwd`
SOURCE_PATH=${PROJECT_PATH}/source
CONFIGS_PATH=${PROJECT_PATH}/configs
INSTALL_PATH=${PROJECT_PATH}/install-hisiv500

CC=arm-hisiv500-linux-uclibcgnueabi-gcc
CXX=arm-hisiv500-linux-uclibcgnueabi-g++
AR=arm-hisiv500-linux-uclibcgnueabi-ar

export CC
export CXX
export AR

export PROJECT_PATH
export SOURCE_PATH
export INSTALL_PATH
export CONFIGS_PATH
export N_JOBS=${N_JOBS:-4}

pushd "${PROJECT_PATH}"

#------------------ BUILD
# xxx.sh version

./scripts/build_zlib.sh 1.2.11
./scripts/build_openssl.sh 1.1.1d
./scripts/build_openssh.sh portable-8.1.p1
./scripts/build_rzsz.sh 3.48

popd

echo "DONE!!!"
