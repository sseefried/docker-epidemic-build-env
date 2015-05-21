#!/bin/bash

THIS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $THIS_DIR/set-env.sh
####################################################################################################

SHA1=8791343cbf6d99451f4d08e8209d6ac11bf96df2
FILE=pixman-0.32.6.tar.gz
FULL_PATH="$DOWNLOADS/$FILE"

echo "Downloading Pixman 0.32.6"

curl -o "$FULL_PATH" "$FILES_URL/$FILE" 2>&1
check_sha1 $FULL_PATH $SHA1

