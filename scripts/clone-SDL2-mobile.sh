#!/bin/bash

THIS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $THIS_DIR/set-env.sh
####################################################################################################

echo "Cloning SDL2-mobile"

git clone https://github.com/sseefried/SDL2-mobile.git
cd SDL2-mobile
git checkout a749c9e06fbaf25d9d7c9662bb92079cf9a2a084 2>&1