#!/usr/bin/env bash
set -euo pipefail
set -x

PACKAGE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
INSTALLER="${PACKAGE_DIR}/vendir/aws/install"
INSTALL_DIR="${PACKAGE_DIR}/aws-cli"
BIN_DIR="${PACKAGE_DIR}/bin"

[ -f "${INSTALLER}" ] || { echo "installer missing: ${INSTALLER}" >&2; exit 1; }
mkdir -p "${INSTALL_DIR}" "${BIN_DIR}"

bash "${INSTALLER}" --install-dir "${INSTALL_DIR}" --bin-dir "${BIN_DIR}" || true

for f in \
  "${INSTALL_DIR}/v2/current/bin/aws" \
  "${INSTALL_DIR}/v2/current/bin/aws_completer"
do
  [ -e "$f" ] && chmod +x "$f" || true
done

[ -x "${INSTALL_DIR}/v2/current/bin/aws" ] && ln -sf "${INSTALL_DIR}/v2/current/bin/aws" "${BIN_DIR}/aws"
[ -x "${INSTALL_DIR}/v2/current/bin/aws_completer" ] && ln -sf "${INSTALL_DIR}/v2/current/bin/aws_completer" "${BIN_DIR}/aws_completer"

if ! (echo -e '#!/bin/sh\necho ok' > "${BIN_DIR}/.x" && chmod +x "${BIN_DIR}/.x" && "${BIN_DIR}/.x" >/dev/null 2>&1); then
  echo "WARNING: filesystem may be mounted with 'noexec'; binaries won't run from ${PACKAGE_DIR}." >&2
fi
rm -f "${BIN_DIR}/.x"
