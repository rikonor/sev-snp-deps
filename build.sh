#!/usr/bin/env bash

set -euo pipefail

BUILD_DIR=$(mktemp -d)
CONFIG_CMD="scripts/config --file ${BUILD_DIR}/.config"

CONFIG_PATH="${CONFIG_PATH:-}"
if [[ -z "${CONFIG_PATH}" ]]; then
    echo "missing CONFIG_PATH"
    exit 1
fi

OUT_DIR="${OUT_DIR:-}"
if [[ -z "${OUT_DIR}" ]]; then
    echo "missing OUT_DIR"
    exit 1
fi

# Clean up
make O=${BUILD_DIR} distclean

# Configuration
cp "${CONFIG_PATH}" "${BUILD_DIR}"
${CONFIG_CMD} --set-str LOCALVERSION "${LOCALVERSION}"

# Build and package
make O=${BUILD_DIR} -j$(nproc) bindeb-pkg

# Output
find / -name "linux-*.deb" -exec cp {} "${OUT_DIR}" \;
