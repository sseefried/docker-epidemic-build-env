#!/bin/bash

THIS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $THIS_DIR/set-env.sh
####################################################################################################

cabal unpack vector-0.10.12.1
cd vector-0.10.12.1

#
# This patch is required to remove a ANN pragma which does not work with cross-compilers.
#

patch -p0 < ../vector-0.10.12.1.patch

arm-linux-androideabi-cabal install