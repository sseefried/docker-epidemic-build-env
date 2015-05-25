#!/bin/bash

THIS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $THIS_DIR/set-env.sh
###################################################################################################

GHC=$HOME/.ghc/android-host/bin/ghc

cd hsSDL2
$GHC --make Setup.lhs
arm-linux-androideabi-cabal-setup.sh configure
DST=dist/arm-linux-androideabi/build/Graphics/UI/SDL
mkdir -p $DST
cp src-ios-simulator-and-armv7/Graphics/UI/SDL/* dist/arm-linux-androideabi/build/Graphics/UI/SDL
arm-linux-androideabi-cabal-setup.sh build
arm-linux-androideabi-cabal-setup.sh install

