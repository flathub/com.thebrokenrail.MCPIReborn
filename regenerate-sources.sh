#!/bin/sh

set -e

# Create Working Directory
rm -rf tmp
mkdir tmp
cd tmp

# Install Tools
git clone --depth 1 https://github.com/flatpak/flatpak-builder-tools.git
pipx install --force flatpak-builder-tools/node

# Generate
git clone --depth 1 https://gitea.thebrokenrail.com/minecraft-pi-reborn/symbol-processor.git
flatpak-node-generator npm symbol-processor/package-lock.json -o ../generated-sources.json