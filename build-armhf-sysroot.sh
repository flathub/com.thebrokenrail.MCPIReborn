#!/bin/sh

set -e

# Prepare
rm -f armhf-sysroot.tar.gz

# Clone
rm -rf minecraft-pi-reborn
git clone --depth 1 https://gitea.thebrokenrail.com/TheBrokenRail/minecraft-pi-reborn.git

# Build
cd minecraft-pi-reborn
mkdir out
mkdir build
cd build
cmake \
    -DMCPI_BUILD_MODE=native \
    -DMCPI_SERVER_MODE=ON \
    -DMCPI_OPEN_SOURCE_ONLY=ON \
    ..
make -j$(nproc)
make install DESTDIR="$(cd ../out; pwd)"

# Create Archive
cd ../out/usr/lib/minecraft-pi-reborn-server/sysroot
tar -czf ../../../../../../armhf-sysroot.tar.gz *

# Cleanup
cd ../../../../../../
rm -rf minecraft-pi-reborn
