#!/usr/bin/env bash

set -euo pipefail

OUTPUT_DIR=$(mktemp -d)
CONFIG_CMD="scripts/config --file ${OUTPUT_DIR}/.config"

CONFIG_PATH="${CONFIG_PATH:-}"
if [[ -z "${CONFIG_PATH}" ]]; then
    echo "missing CONFIG_PATH"
    exit 1
fi

# Clean up
make O=${OUTPUT_DIR} distclean

# Configuration
cp "${CONFIG_PATH}" "${OUTPUT_DIR}"
${CONFIG_CMD} --set-str LOCALVERSION "${LOCALVERSION}"

# Build and package
make O=${OUTPUT_DIR} -j$(nproc) bindeb-pkg
