#!/bin/bash

set -x
set -eo pipefail

PACKAGE_DIR=$(cd "$(dirname $BASH_SOURCE)/.."; pwd)

mv $PACKAGE_DIR/bin/argocd-linux-amd64 $PACKAGE_DIR/bin/argocd 
