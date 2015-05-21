#!/bin/bash

THIS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $THIS_DIR/set-env.sh
###################################################################################################

tar xzf "$DOWNLOADS/libogg-1.3.2.tar.gz"
cd libogg-1.3.2
./configure --host=$HOST --prefix=$NDK_ADDON_PREFIX --disable-shared --enable-static
make
make install
