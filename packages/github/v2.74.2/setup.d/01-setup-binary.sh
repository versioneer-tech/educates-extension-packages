#!/bin/bash

set -x
set -eo pipefail

PACKAGE_DIR=$(cd "$(dirname $BASH_SOURCE)/.."; pwd)

# Do whatever is needed
# Rename the binary
mv $PACKAGE_DIR/bin/$PLATFORM_ARCH/gh_2.74.2_linux_$PLATFORM_ARCH/bin/gh $PACKAGE_DIR/bin/gh

unset PACKAGE_DIR