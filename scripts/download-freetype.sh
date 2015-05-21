#!/bin/bash

THIS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $THIS_DIR/set-env.sh
####################################################################################################

SHA1=e2731e7a083efbeb46247b699aa9722438deeb5e
FILE=freetype-2.5.4.tar.gz
FULL_PATH="$DOWNLOADS/$FILE"

echo "Downloading Freetype 2.5.4"

curl -o "$FULL_PATH" "$FILES_URL/$FILE" 2>&1
check_sha1 $FULL_PATH $SHA1

