#!/bin/bash

#
# This script is responsible for setting up all the environment variables exactly the way
# they should be. It will be sourced from other build scripts, but not
# run directly by Docker.
#

PLATFORM_PREFIX=$HOME/.ghc/android-14/arm-linux-androideabi-4.8
NDK_ADDON_PREFIX=$PLATFORM_PREFIX/sysroot/usr

export PATH=$PATH:$PLATFORM_PREFIX/bin:$NDK_ADDON_PREFIX/bin

# Basic configuration
export MAKEFLAGS=${MAKEFLAGS:--j9}
HOST=arm-linux-androideabi
NDK_PATH=$HOME/android-ndk-r9b

export PKG_CONFIG_PATH=$NDK_ADDON_PREFIX/lib/pkgconfig


BUILD_DIR=$HOME/build
DOWNLOADS=$HOME/build/downloads
FILES_URL="http://declarative-games.com/files/epidemic-libs"

mkdir -p $BUILD_DIR
mkdir -p $DOWNLOADS

function check_sha1() {
    FILENAME="$1"
    SHA1="$2"
    [ -e "${FILENAME}" ] || return 1;
    ACTUAL_SHA1=$(sha1sum "$FILENAME" | cut -f1 -d ' ')
    if [ ! "$ACTUAL_SHA1" == "$SHA1" ]; then
      >&2 echo "SHA1 hash of $FILENAME did not match."
      >&2 echo "$SHA1 =/= $ACTUAL_SHA1"
      exit 1
    fi
}