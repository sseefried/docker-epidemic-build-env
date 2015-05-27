#!/bin/bash

THIS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $THIS_DIR/set-env.sh
###################################################################################################

cd epidemic-game
arm-linux-androideabi-cabal install MonadRandom-0.3 control-monad-free-0.5.3

arm-linux-androideabi-cabal install -fandroid
