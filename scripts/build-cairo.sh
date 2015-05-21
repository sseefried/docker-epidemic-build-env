#!/bin/bash

THIS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $THIS_DIR/set-env.sh
###################################################################################################

DIR=cairo-1.12.16

tar xf "$DOWNLOADS/cairo-1.12.16-small.tar.xz"
cp $THIS_DIR/locale.h.android $DIR/locale.h || exit 1
cd $DIR

CC=$HOST-gcc LD=$HOST-ld  \
  ./configure --host=$HOST \
  --prefix=$NDK_ADDON_PREFIX \
  --enable-ft --disable-fc --disable-xlib --disable-quartz \
  --enable-static --disable-shared

make
make install