#!/bin/bash

THIS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $THIS_DIR/set-env.sh
####################################################################################################

SHA1=8c2e876305bb40ddfae34911887a4de770c2a461
FILE=cairo-1.12.16-small.tar.xz
FULL_PATH="$DOWNLOADS/$FILE"

echo "Downloading Cairo 1.12.16"

curl -o "$FULL_PATH" "$FILES_URL/$FILE" 2>&1
check_sha1 $FULL_PATH $SHA1

