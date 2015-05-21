#!/bin/bash

THIS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $THIS_DIR/set-env.sh
####################################################################################################

SHA1=df7f3977bbeda67306bc2a427257dd7375319d7d
FILE=libogg-1.3.2.tar.gz
FULL_PATH="$DOWNLOADS/$FILE"

echo "Downloading libvorbis"

curl -o "$FULL_PATH" "$FILES_URL/$FILE" 2>&1
check_sha1 $FULL_PATH $SHA1

