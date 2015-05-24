#!/bin/bash

THIS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $THIS_DIR/set-env.sh
###################################################################################################

cd SDL2-mobile

#
# We use NDK to build the library
#

$NDK_PATH/ndk-build NDK_PROJECT_PATH=. \
  APP_BUILD_SCRIPT=./Android.mk \
  APP_PLATFORM=android-14 SDL2_static

SRC_DIR=$THIS_DIR/SDL2-mobile
BUILD_DIR=$SRC_DIR/obj/local/armeabi

#
# But then we have to manually install the headers and the static library
#

cp $BUILD_DIR/libSDL2.a $NDK_ADDON_PREFIX/lib || exit 1

mkdir -p $NDK_ADDON_PREFIX/include/SDL2
cp $SRC_DIR/include/*.h $NDK_ADDON_PREFIX/include/SDL2 || exit 1

cp $THIS_DIR/sdl2-config $NDK_ADDON_PREFIX/bin || exit 1