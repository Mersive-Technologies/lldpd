#!/bin/bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
LLDPD_DIR=$(realpath ${SCRIPT_DIR}/..)

cd ${SCRIPT_DIR}
docker build -t lldpd_build . || exit 1

docker run \
    -it \
    --rm \
    -v ${LLDPD_DIR}:/home/devel/lldpd \
    -- \
    lldpd_build
