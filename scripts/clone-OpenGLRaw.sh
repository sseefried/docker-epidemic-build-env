#!/bin/bash

THIS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $THIS_DIR/set-env.sh
####################################################################################################


git clone --branch epidemic-game https://github.com/sseefried/OpenGLRaw.git
cd OpenGLRaw
git checkout 4a24f2dbbec674e018608d10852ce50259f14b91 2>&1