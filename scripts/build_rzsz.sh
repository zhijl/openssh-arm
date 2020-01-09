#!/usr/bin/env bash

set -eu

if [ $# -ne 1 ]; then
  echo $#
  echo "Usage: " $0 "xxx.sh x.x.x"
  exit 1
fi


RZSZ_VERSION="$1"
RZSZ_SOURCE=rzsz-"${RZSZ_VERSION}"
RZSZ_ROOT=${SOURCE_PATH}/${RZSZ_SOURCE}

pushd "${RZSZ_ROOT}"

cp ${CONFIGS_PATH}/hisiv500/${RZSZ_SOURCE}/Makefile .
make clean
make posix

rm -rf "${INSTALL_PATH}/rzsz"
mkdir -p "${INSTALL_PATH}/rzsz/bin"

cp gz rb rc rx rz sb sx sz zcommand zcommandi "${INSTALL_PATH}/rzsz/bin"

popd
