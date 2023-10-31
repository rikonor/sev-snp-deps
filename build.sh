#!/usr/bin/env bash

set -eo pipefail

SOURCE_DIR="${SOURCE_DIR:-}"
if [[ -z "${SOURCE_DIR}" ]]; then
    echo "missing SOURCE_DIR"
    exit 1
fi

OUT_DIR="${OUT_DIR:-}"
if [[ -z "${OUT_DIR}" ]]; then
    echo "missing OUT_DIR"
    exit 1
fi

# Build
make -C BaseTools
source edksetup.sh --reconfig
build \
    --arch="X64" \
    --platform="OvmfPkg/OvmfPkgX64.dsc" \
    --tagname="GCC5" \
    -n $(nproc)

# Output
cp "${SOURCE_DIR}/Build/OvmfX64/DEBUG_GCC5/FV/OVMF.fd" "${OUT_DIR}"
cp "${SOURCE_DIR}/Build/OvmfX64/DEBUG_GCC5/FV/OVMF_VARS.fd" "${OUT_DIR}"
cp "${SOURCE_DIR}/Build/OvmfX64/DEBUG_GCC5/FV/OVMF_CODE.fd" "${OUT_DIR}"
