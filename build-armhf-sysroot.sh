#!/bin/sh

set -e

# Prepare
rm -f armhf-sysroot.tar.gz

# Clone
rm -rf minecraft-pi-reborn
git clone --depth 1 --recurse-submodules https://gitea.thebrokenrail.com/TheBrokenRail/minecraft-pi-reborn.git

# Build
cd minecraft-pi-reborn
mkdir out
mkdir build
cd build
cmake \
    -DCMAKE_TOOLCHAIN_FILE=../cmake/armhf-toolchain.cmake \
    -DMCPI_BUILD_MODE=arm \
    -DMCPI_SERVER_MODE=ON \
    -DMCPI_OPEN_SOURCE_ONLY=ON \
    -DMCPI_IS_MIXED_BUILD=ON \
    ..
make -j$(nproc)
make install DESTDIR="$(cd ../out; pwd)"

# Create Archive
cd ../out/usr/lib/minecraft-pi-reborn-server/sysroot
tar -czf ../../../../../../armhf-sysroot.tar.gz *

# Cleanup
cd ../../../../../../
rm -rf minecraft-pi-reborn
