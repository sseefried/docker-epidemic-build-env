#!/bin/bash

THIS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $THIS_DIR/set-env.sh
####################################################################################################

git clone https://github.com/sseefried/helm.git
cd helm
git checkout da5239162776e8572053ac2ca35c09bae6a4d13a 2>&1