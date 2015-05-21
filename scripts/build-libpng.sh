#!/bin/bash

THIS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $THIS_DIR/set-env.sh
###################################################################################################


tar xf "$DOWNLOADS/libpng-1.6.17.tar.xz"
cd libpng-1.6.17

./configure --host=$HOST --prefix=$NDK_ADDON_PREFIX
make install