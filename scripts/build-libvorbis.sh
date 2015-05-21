#!/bin/bash

THIS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $THIS_DIR/set-env.sh
###################################################################################################

tar xf "$DOWNLOADS/libvorbis-1.3.4.tar.xz"
cd libvorbis-1.3.4
./configure --host=$HOST --prefix=$NDK_ADDON_PREFIX --disable-shared --enable-static
make
make install
