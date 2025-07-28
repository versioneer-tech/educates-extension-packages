#!/bin/bash

set -x
set -eo pipefail

PACKAGE_DIR=$(cd "$(dirname $BASH_SOURCE)/.."; pwd)

# Install extensions
# When platform arch is amd64, we need to modify the variable used to x64
PLATFORM=$PLATFORM_ARCH
if [ "$PLATFORM_ARCH" = "amd64" ]; then
  PLATFORM="x64"
fi

code-server --install-extension $PACKAGE_DIR/extensions/$PLATFORM/Continue.continue-1.1.63@linux-$PLATFORM.vsix

unset PACKAGE_DIR