#!/usr/bin/env bash
set -euo pipefail
set -x

PACKAGE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
BIN_DIR="${PACKAGE_DIR}/bin"
VERSION="1.71.0"
RCLONE_ZIP="rclone-v${VERSION}-linux-${PLATFORM_ARCH}.zip"
RCLONE_URL="https://downloads.rclone.org/v${VERSION}/${RCLONE_ZIP}"

mkdir -p "${BIN_DIR}"

curl -L -o "/tmp/${RCLONE_ZIP}" "${RCLONE_URL}"
unzip -j -d "${BIN_DIR}" "/tmp/${RCLONE_ZIP}" "*/rclone"
rm "/tmp/${RCLONE_ZIP}"

chmod +x "${BIN_DIR}/rclone"

if ! (echo -e '#!/bin/sh\necho ok' > "${BIN_DIR}/.x" && chmod +x "${BIN_DIR}/.x" && "${BIN_DIR}/.x" >/dev/null 2>&1); then
  echo "WARNING: filesystem may be mounted with 'noexec'; binaries won't run from ${PACKAGE_DIR}." >&2
fi
rm -f "${BIN_DIR}/.x"
