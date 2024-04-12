#!/bin/bash

set -x
set -eo pipefail

PACKAGE_DIR=$(cd "$(dirname $BASH_SOURCE)/.."; pwd)

# Do whatever is needed
# Rename the binary
mv $PACKAGE_DIR/bin/argocd-linux-amd64 $PACKAGE_DIR/bin/argocd

unset PACKAGE_DIR