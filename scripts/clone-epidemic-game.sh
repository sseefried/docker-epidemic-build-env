#!/bin/bash

THIS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $THIS_DIR/set-env.sh
####################################################################################################


git clone https://github.com/sseefried/open-epidemic-game.git
cd open-epidemic-game
git checkout ae30300f93fa559d0f677247edbe1745a74d99b8 2>&1