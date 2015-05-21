#!/bin/bash

THIS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $THIS_DIR/set-env.sh
####################################################################################################

SHA1=b99724acdf3577982b3146b9430d765995ecf9e1
FILE=libvorbis-1.3.4.tar.xz
FULL_PATH="$DOWNLOADS/$FILE"

echo "Downloading libvorbis"

curl -o "$FULL_PATH" "$FILES_URL/$FILE" 2>&1
check_sha1 $FULL_PATH $SHA1

