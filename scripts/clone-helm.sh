#!/bin/bash

THIS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $THIS_DIR/set-env.sh
####################################################################################################

git clone https://github.com/sseefried/helm.git
cd helm
git checkout 7a715a7a3f8fb071879984bc8b7c0d0baabf6a37 2>&1