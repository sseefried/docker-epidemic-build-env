#!/bin/bash

THIS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $THIS_DIR/set-env.sh
###################################################################################################

git clone https://github.com/sseefried/hs-cairo.git
cd hs-cairo
git checkout dc3fbf0568103987fdadd00786a6d2ce80584875 2>&1