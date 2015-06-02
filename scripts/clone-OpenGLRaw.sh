#!/bin/bash

THIS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $THIS_DIR/set-env.sh
####################################################################################################


git clone --branch epidemic-game https://github.com/sseefried/OpenGLRaw.git
cd OpenGLRaw
git checkout c14b666c244cfcb2cda4708b21360c7ff21b342e 2>&1