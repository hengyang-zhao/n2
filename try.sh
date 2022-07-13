#!/usr/bin/env bash

set -euo pipefail

if [ ${BASH_VERSINFO[0]} -lt 4 ]; then
    echo "Your bash version ($BASH_VERSION) is too low."
    echo "Requires at least 4.x."
    exit 1
fi

N2_DIR=$(cd "$(dirname "$0")"; pwd)

PLAYGROUND_DIR="$N2_DIR/volatile/playground"

echo -
echo - Trying N2 in dir $PLAYGROUND_DIR
echo -

rm -rf "$PLAYGROUND_DIR"
mkdir -p "$PLAYGROUND_DIR"

HOME=$PLAYGROUND_DIR bash -c "cd ~ && AUTO_CONFIRM=yes $N2_DIR/install.sh"
HOME=$PLAYGROUND_DIR bash --login

echo -
echo - Cleaning up N2 playground dir $PLAYGROUND_DIR
echo -
