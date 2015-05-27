#!/bin/bash

THIS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $THIS_DIR/set-env.sh
####################################################################################################

cd hs-cairo
GHC=$HOME/.ghc/android-host/bin/ghc

$GHC --make Setup.hs
arm-linux-androideabi-cabal-setup.sh configure
arm-linux-androideabi-cabal-setup.sh build
arm-linux-androideabi-cabal-setup.sh install
