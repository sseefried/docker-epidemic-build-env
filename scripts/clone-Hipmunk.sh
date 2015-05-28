#!/bin/bash

THIS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $THIS_DIR/set-env.sh
####################################################################################################


git clone https://github.com/sseefried/Hipmunk.git
cd Hipmunk
git checkout d215edcbad12aa3cdf849c960e02fb4d3b0ef34d 2>&1