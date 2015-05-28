#!/bin/bash

THIS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $THIS_DIR/set-env.sh
####################################################################################################

git clone https://github.com/sseefried/hs-sdl2-mixer.git
cd hs-sdl2-mixer
git checkout e6bd509a59fc4907d01b49309c2e381e4ec04a1e 2>&1