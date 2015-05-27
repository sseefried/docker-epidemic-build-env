#!/bin/bash

THIS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $THIS_DIR/set-env.sh
###################################################################################################

cd SDL2_mixer-mobile

#CFLAGS="-DGL_GLEXT_PROTOTYPES" \
#  LDFLAGS="-ldl -lGLESv1_CM -lGLESv2 -llog -landroid" \
  ./configure --host=$HOST --prefix=$NDK_ADDON_PREFIX \
  --disable-shared --enable-static \
  --enable-music-ogg --disable-music-midi-native

# Just install the libraries.
make install-lib

# Install the pkg-config file manually
cp SDL2_mixer.pc $PKG_CONFIG_PATH || exit 1

# Install the header manually

cp SDL_mixer.h $NDK_ADDON_PREFIX/include/SDL2 || exit 1