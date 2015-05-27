#!/bin/bash

THIS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $THIS_DIR/set-env.sh
####################################################################################################

arm-linux-androideabi-cabal install mtl-2.2.1 utf8-string-0.3.8