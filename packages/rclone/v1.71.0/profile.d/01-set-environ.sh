#!/bin/bash

PACKAGE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.."; pwd)"
PATH="$PACKAGE_DIR/bin:$PATH"

if command -v rclone >/dev/null 2>&1 && [ -n "${BASH_VERSION:-}" ]; then
  complete -p rclone >/dev/null 2>&1 || eval "$(rclone completion bash 2>/dev/null)" || true
fi

unset PACKAGE_DIR
