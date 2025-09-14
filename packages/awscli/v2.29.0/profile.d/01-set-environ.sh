#!/bin/bash

PACKAGE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.."; pwd)"
PATH="$PACKAGE_DIR/bin:$PATH"

if [ -n "${BASH_VERSION:-}" ] && command -v aws >/dev/null 2>&1; then
  COMPLETER=""
  if [ -x "$PACKAGE_DIR/aws-cli/v2/current/bin/aws_completer" ]; then
    COMPLETER="$PACKAGE_DIR/aws-cli/v2/current/bin/aws_completer"
  elif command -v aws_completer >/dev/null 2>&1; then
    COMPLETER="$(command -v aws_completer)"
  fi

  if [ -n "$COMPLETER" ]; then
    complete -p aws >/dev/null 2>&1 || complete -C "$COMPLETER" aws 2>/dev/null || true
  fi
fi

unset PACKAGE_DIR COMPLETER
