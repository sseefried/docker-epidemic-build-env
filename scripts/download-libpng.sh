#!/bin/bash

THIS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $THIS_DIR/set-env.sh
####################################################################################################

SHA1=6394f3c0847c3b9ea69f4f972dddae3786592050
FILE=libpng-1.6.17.tar.xz
FULL_PATH="$DOWNLOADS/$FILE"

echo "Downloading libpng 1.6.17"

curl -o "$FULL_PATH" "$FILES_URL/$FILE" 2>&1
check_sha1 $FULL_PATH $SHA1

