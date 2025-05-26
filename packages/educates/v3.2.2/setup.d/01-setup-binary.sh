#!/bin/bash

set -x
set -eo pipefail

PACKAGE_DIR=$(cd "$(dirname $BASH_SOURCE)/.."; pwd)

# Do whatever is needed
# Rename the binary
mv $PACKAGE_DIR/bin/educates-linux-$PLATFORM_ARCH $PACKAGE_DIR/bin/educates

unset PACKAGE_DIR