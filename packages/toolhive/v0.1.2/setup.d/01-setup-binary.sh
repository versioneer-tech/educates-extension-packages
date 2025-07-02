#!/bin/bash

set -x
set -eo pipefail

PACKAGE_DIR=$(cd "$(dirname $BASH_SOURCE)/.."; pwd)

# Do whatever is needed
# Rename the binary
mv $PACKAGE_DIR/bin/$PLATFORM_ARCH/thv $PACKAGE_DIR/bin/thv

unset PACKAGE_DIR