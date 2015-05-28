#!/bin/bash

THIS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $THIS_DIR/set-env.sh
####################################################################################################

echo "Cloning hsSDL2"
git clone https://github.com/sseefried/hsSDL2.git
cd hsSDL2
git checkout cd6404784b784452bdda2bccfa37a78a69bf982f 2>&1