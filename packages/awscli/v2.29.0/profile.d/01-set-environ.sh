#!/bin/bash

PACKAGE_DIR=$(cd "$(dirname $BASH_SOURCE)/.."; pwd)

PATH=$PACKAGE_DIR/bin:$PATH

if ! command -v aws >/dev/null 2>&1; then
    return
fi

complete -C aws_completer aws

unset PACKAGE_DIR