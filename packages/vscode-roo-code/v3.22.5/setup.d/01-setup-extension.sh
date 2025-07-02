#!/bin/bash

set -x
set -eo pipefail

PACKAGE_DIR=$(cd "$(dirname $BASH_SOURCE)/.."; pwd)

# Install extensions
code-server --install-extension $PACKAGE_DIR/extensions/RooVeterinaryInc.roo-cline-3.22.5.vsix

unset PACKAGE_DIR