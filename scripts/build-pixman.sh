#!/bin/bash

THIS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $THIS_DIR/set-env.sh
###################################################################################################

tar xzf "$DOWNLOADS/pixman-0.32.6.tar.gz"
cd pixman-0.32.6
LIBS="-lcpufeatures" ./configure --host=$HOST --prefix=$NDK_ADDON_PREFIX \
  --disable-shared --enable-static

make install
