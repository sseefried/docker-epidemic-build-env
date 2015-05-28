#!/bin/bash

THIS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $THIS_DIR/set-env.sh
####################################################################################################

echo "Cloning SDL2_mixer-mobile"

git clone https://github.com/sseefried/SDL2_mixer-mobile.git
cd SDL2_mixer-mobile
git checkout 4b9da92f530a6e7c0d9a1da1b6212fc877cf8ce3 2>&1