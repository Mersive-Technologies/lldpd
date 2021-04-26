#!/bin/bash

uid=${UID:-1000}
gid=${GID:-1000}

echo "Starting with UID:GID : $uid:$gid"
usermod -u $uid devel &> /dev/null
usermod -g $gid devel &> /dev/null

export HOME=/home/devel

cd /home/devel/lldpd

./autogen.sh

mkdir -p build && cd build

rm -rf *

../configure --host=$TARGET \
             --with-sysroot=$TOOLCHAIN/sysroot \
             --prefix=/system \
             --sbindir=/system/bin \
             --runstatedir=/data/data/lldpd \
             --with-privsep-user=root \
             --with-privsep-group=root \
             PKG_CONFIG=/bin/false \
             --enable-shared

make

mkdir -p ../dist
rm -rf ../dist/*

make install DESTDIR=/home/devel/lldpd/dist