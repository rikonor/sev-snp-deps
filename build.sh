#!/usr/bin/env bash

set -euo pipefail

SOURCE_DIR="${SOURCE_DIR:-}"
if [[ -z "${SOURCE_DIR}" ]]; then
    echo "missing SOURCE_DIR"
    exit 1
fi

# Configure
${SOURCE_DIR}/configure \
    --target-list=x86_64-softmmu \
    --with-git-submodules=ignore

# Build
make -j$(nproc)

# Install
make install

# Package
checkinstall -D -y \
    --pkgname=qemu \
    --pkgversion=8
