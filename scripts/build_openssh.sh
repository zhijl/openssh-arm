#!/usr/bin/env bash

set -eu

if [ $# -ne 1 ]; then
  echo $#
  echo "Usage: " $0 "xxx.sh x.x.x"
  exit 1
fi

OPENSSH_VERSION="$1"
OPENSSH_SOURCE=openssh-"${OPENSSH_VERSION}"
OPENSSH_ROOT=${SOURCE_PATH}/${OPENSSH_SOURCE}

pushd "${OPENSSH_ROOT}"

if [ ! -f configure ]; then
autoconf
fi

if [[ $CC == "*arm*" ]]
then
    HOST="arm"
else
    HOST="x86_64"
fi

## To solve `config.status: error: cannot find input file: `config.h.in'`
aclocal
autoheader
autoconf

## To solve no found `libcrypto.so.1.1` when testing in configure (x86_64 build)
export LD_LIBRARY_PATH=${INSTALL_PATH}/openssl/lib
./configure --host=${HOST} --with-ssl-dir=${INSTALL_PATH}/openssl --with-zlib=${INSTALL_PATH}/zlib --disable-etc-default-login CC=${CC} AR=${AR} --prefix="${INSTALL_PATH}/openssh"

make clean
make -j"${N_JOBS}" CC=${CC} CXX=${CXX}

rm -rf "${INSTALL_PATH}/openssh"

mkdir -p "${INSTALL_PATH}/openssh"
mkdir -p "${INSTALL_PATH}/openssh/usr/local/bin"
mkdir -p "${INSTALL_PATH}/openssh/usr/local/etc"
mkdir -p "${INSTALL_PATH}/openssh/usr/libexec"

cp scp sftp ssh sshd ssh-add ssh-agent ssh-keygen ssh-keyscan "${INSTALL_PATH}/openssh/usr/local/bin"
cp moduli ssh_config sshd_config "${INSTALL_PATH}/openssh/usr/local/etc"
cp sftp-server ssh-keysign "${INSTALL_PATH}/openssh/usr/libexec"

popd
