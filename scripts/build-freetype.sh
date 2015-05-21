#!/bin/bash

THIS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $THIS_DIR/set-env.sh
###################################################################################################

tar xzf "$DOWNLOADS/freetype-2.5.4.tar.gz"
cd freetype-2.5.4

CC=$HOST-gcc ./configure --host=$HOST --prefix=$NDK_ADDON_PREFIX
make
make install