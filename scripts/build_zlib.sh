#!/usr/bin/env bash

set -eu

if [ $# -ne 1 ]; then
  echo $#
  echo "Usage: " $0 "xxx.sh x.x.x"
  exit 1
fi

ZLIB_VERSION="$1"
ZLIB_ROOT=${SOURCE_PATH}/zlib-"${ZLIB_VERSION}"
BUILD_PATH=${ZLIB_ROOT}/build

if [[ $CC == "*arm*" ]]
then
    CMAKE_TOOLCHAIN_FILE="${PROJECT_PATH}/configs/hisiv500.toolchain.cmake"
else
    CMAKE_TOOLCHAIN_FILE=""
fi

rm -rf "${BUILD_PATH}"
mkdir -p "${BUILD_PATH}"
pushd "${BUILD_PATH}"

cmake -DCMAKE_TOOLCHAIN_FILE="${CMAKE_TOOLCHAIN_FILE}" \
      -DCMAKE_C_COMPILER="${CC}" \
      -DCMAKE_BUILD_TYPE=Release \
      -DBUILD_SHARED_LIBS=OFF \
      -DCMAKE_INSTALL_PREFIX="${INSTALL_PATH}/zlib" \
      ..

make -j"${N_JOBS}"
rm -rf "${INSTALL_PATH}/zlib"
make install

popd
