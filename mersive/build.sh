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

# Doing a build dirties this directory. We don't want to leave repo dirty.
rm -rf ${LLDPD_DIR}/libevent/build-aux

echo "LLDPD built from $(git remote -v | grep fetch | cut -f2 | cut -f1 -d' ')" > ${LLDPD_DIR}/dist/VERSION
echo "  built on $(hostname) by $(git config --get user.name) [$(git config --get user.email)] at $(date)" >> ${LLDPD_DIR}/dist/VERSION
echo "  current branch is $(git branch --show-current)" >> ${LLDPD_DIR}/dist/VERSION
echo "  current commit is $(git rev-parse HEAD)" >> ${LLDPD_DIR}/dist/VERSION
echo "" >> ${LLDPD_DIR}/dist/VERSION
echo "  git status is:" >> ${LLDPD_DIR}/dist/VERSION
git status | sed "s/^/    /g" >> ${LLDPD_DIR}/dist/VERSION