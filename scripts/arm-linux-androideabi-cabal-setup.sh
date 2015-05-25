#!/bin/bash

#
# This script should be used when arm-linux-androideabi-cabal cannot be used
# because the cabal file is not using Distribution.Simple.
#
# In this case manually build Setup.hs (to executable "Setup") for the host machine,
# then run this script.
#
#   $ ghc --make Setup.hs
#   $ arm-linux-androideabi-cabal-setup.sh
#

if [ ! -f  Setup ]; then
  if [ -f Setup.hs -o -f Setup.lhs ]; then
    ghc --make Setup.?hs
  fi
  if [ ! -f  Setup ]; then
    echo Could not find 'Setup or Setup.(l)hs'
    exit 1
  fi
fi

if [ $# -lt 1 ]; then
  echo "Usage: $(basename $0) clean|configure|build|install"
  exit 1
fi

ARG=$1
shift

ARCH=arm-linux-androideabi
GHC_PREFIX=arm-unknown-linux-androideabi
BUILDDIR=dist/$ARCH

case $ARG in
  clean)
    ./Setup clean
  ;;
  configure)
    ./Setup configure  \
      --ghc \
      --builddir=$BUILDDIR \
      --with-compiler=$GHC_PREFIX-ghc \
      --with-gcc=$ARCH-gcc \
      --with-ld=$ARCH-ld \
      --with-ghc-pkg=$GHC_PREFIX-ghc-pkg \
      --with-hc-pkg=$GHC_PREFIX-ghc-pkg \
      --with-strip=$ARCH-strip \
      --hsc2hs-options=--cross-compile \
      --prefix=/home/androidbuilder/.ghc/android-14/arm-linux-androideabi-4.8/cabal \
      --package-db=user \
      "$@"
  ;;

  build)
    ./Setup build --builddir=$BUILDDIR "$@"
  ;;

  install)
    ./Setup install --builddir=$BUILDDIR "$@"
  ;;
  *)
    echo "Unknown command. Use configure|build|install"
  ;;
esac
