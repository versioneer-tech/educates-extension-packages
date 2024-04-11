#!/bin/bash

set -x
set -eo pipefail

PACKAGE_DIR=$(cd "$(dirname $BASH_SOURCE)/.."; pwd)

chmod 755 $PACKAGE_DIR/bin/crane