#!/usr/bin/env bash

set -eu

# config project path and install path
PROJECT_PATH=`pwd`
SOURCE_PATH=${PROJECT_PATH}/source

mkdir -p ${SOURCE_PATH}

pushd "${SOURCE_PATH}"

# Clean
rm -rf ${SOURCE_PATH}/*

# Download openssl 1.1.1d 
wget https://github.com/openssl/openssl/archive/OpenSSL_1_1_1d.zip
unzip OpenSSL_1_1_1d.zip
mv openssl-OpenSSL_1_1_1d openssl-1.1.1d

# Download openssh portable v8.1.p1
wget https://github.com/openssh/openssh-portable/archive/V_8_1_P1.zip
unzip V_8_1_P1.zip
mv openssh-portable-V_8_1_P1 openssh-portable-8.1.p1

# Download zlib
wget https://github.com/madler/zlib/archive/v1.2.11.zip
unzip v1.2.11.zip

# Download rzsz-3.48 (unofficial)
git clone https://github.com/coderfordev/rzsz.git
mv rzsz rzsz-3.48

popd

echo "DONE!!!"
