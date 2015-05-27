#!/bin/bash

THIS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $THIS_DIR/set-env.sh
####################################################################################################

#
# Build with the host GHC not the cross compiler.
#

CABAL=$HOME/.cabal/bin/cabal
$CABAL install -j9 alex-3.1.4   || exit 1
$CABAL install -j9 happy-1.19.5 || exit 1
$CABAL install -j9 gtk2hs-buildtools-0.13.0.3 || exit 1