#!/bin/bash

THIS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $THIS_DIR/set-env.sh
###################################################################################################

cd SDL2_mixer-mobile

./configure --host=$HOST --prefix=$NDK_ADDON_PREFIX --disable-shared --enable-static \
  --enable-music-ogg --disable-music-midi-native

# Just install the libraries.
make install-lib