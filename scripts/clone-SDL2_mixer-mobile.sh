#!/bin/bash

THIS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $THIS_DIR/set-env.sh
####################################################################################################

echo "Cloning SDL2_mixer-mobile"

git clone https://github.com/sseefried/SDL2_mixer-mobile.git