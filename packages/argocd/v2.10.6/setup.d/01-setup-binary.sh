#!/bin/bash

set -x
set -eo pipefail

PACKAGE_DIR=$(cd "$(dirname $BASH_SOURCE)/.."; pwd)

# Rename the binary
mv $PACKAGE_DIR/bin/argocd-linux-amd64 $PACKAGE_DIR/bin/argocd 

# Make the binary executable
chmod 755 $PACKAGE_DIR/bin/argocd