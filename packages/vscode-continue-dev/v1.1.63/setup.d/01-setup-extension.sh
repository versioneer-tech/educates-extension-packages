#!/bin/bash

set -x
set -eo pipefail

PACKAGE_DIR=$(cd "$(dirname $BASH_SOURCE)/.."; pwd)

# Install extensions
code-server --install-extension $PACKAGE_DIR/extensions/$PLATFORM_ARCH/Continue.continue-1.1.63@linux-$PLATFORM_ARCH.vsix

unset PACKAGE_DIR