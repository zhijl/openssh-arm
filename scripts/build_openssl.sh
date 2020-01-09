#!/usr/bin/env bash

set -eu

if [ $# -ne 1 ]; then
  echo $#
  echo "Usage: " $0 "xxx.sh x.x.x"
  exit 1
fi


OPENSSL_VERSION="$1"
OPENSSL_SOURCE=openssl-"${OPENSSL_VERSION}"
OPENSSL_ROOT=${SOURCE_PATH}/${OPENSSL_SOURCE}

pushd "${OPENSSL_ROOT}"

if [ ! -f config ]; then
    ./autogen.sh
fi

CFLAGS=-fPIC ./config no-asm no-async -shared -v --prefix="${INSTALL_PATH}/openssl" 

sed -i 's/-m64//g' Makefile

make clean
make -j"${N_JOBS}" CC=${CC} CXX=${CXX}

rm -rf "${INSTALL_PATH}/openssl"

make install

popd
