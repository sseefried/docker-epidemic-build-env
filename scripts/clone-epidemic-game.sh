#!/bin/bash

THIS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $THIS_DIR/set-env.sh
####################################################################################################


git clone https://github.com/sseefried/epidemic-game.git
cd epidemic-game
git checkout dc9c8845c49cc9f56edc2a52c7501d849fbec9e9 2>&1