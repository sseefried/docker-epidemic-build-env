#!/bin/bash

THIS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $THIS_DIR/set-env.sh
####################################################################################################

arm-linux-androideabi-cabal update
CFG=$PLATFORM_PREFIX/.cabal/config

cat $CFG | sed 's/^\(jobs.*\)$/-- \1/' > $CFG.new
rm -f $CFG
mv $CFG.new $CFG

