#!/bin/bash

THIS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $THIS_DIR/set-env.sh
####################################################################################################


git clone https://github.com/sseefried/android-build-epidemic-apk
cd android-build-epidemic-apk
git checkout c0669467be7752faf92e04d531fde431b64e71ba 2>&1