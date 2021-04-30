#!/bin/bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
DIST_DIR=$(realpath ${SCRIPT_DIR}/../dist)

IMG_DIR=$1

if [ ! -e "$IMG_DIR" -o ! -e "$IMG_DIR/mersive/lldpd" ]; then
    echo "Provide the path to your G3 image root dir as the first argument"
    exit 1
fi

if [ ! -e "$DIST_DIR" ]; then
    echo "Build lldpd first, then run this"
    exit 1
fi

cp $DIST_DIR/VERSION $IMG_DIR/mersive/lldpd
cp $DIST_DIR/system/bin/lldpcli $IMG_DIR/mersive/lldpd
cp $DIST_DIR/system/bin/lldpd $IMG_DIR/mersive/lldpd
cp $DIST_DIR/system/lib/liblldpctl.* $IMG_DIR/mersive/lldpd
