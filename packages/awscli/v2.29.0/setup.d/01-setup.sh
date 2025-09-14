#!/usr/bin/env bash
set -euo pipefail
set -x

PACKAGE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
INSTALLER="${PACKAGE_DIR}/vendir/aws/install"
INSTALL_DIR="${PACKAGE_DIR}/aws-cli"
BIN_DIR="${PACKAGE_DIR}/bin"

[ -x "${INSTALLER}" ] || { echo "installer missing: ${INSTALLER}" >&2; exit 1; }
mkdir -p "${INSTALL_DIR}" "${BIN_DIR}"

if [ -x "${BIN_DIR}/aws" ]; then
  "${INSTALLER}" --install-dir "${INSTALL_DIR}" --bin-dir "${BIN_DIR}" --update >/dev/null
else
  "${INSTALLER}" --install-dir "${INSTALL_DIR}" --bin-dir "${BIN_DIR}" >/dev/null
fi

unset PACKAGE_DIR INSTALLER INSTALL_DIR BIN_DIR
