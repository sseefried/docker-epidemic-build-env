#!/bin/bash

THIS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $THIS_DIR/set-env.sh
###################################################################################################

mkdir -p cpufeatures
cd cpufeatures
cp $NDK_PATH/sources/android/cpufeatures/* .

echo $PATH

$HOST-gcc -c cpu-features.c && \
  $HOST-ar cr libcpufeatures.a cpu-features.o && \
  cp libcpufeatures.a $NDK_ADDON_PREFIX/lib && \
  cp cpu-features.h $NDK_ADDON_PREFIX/include