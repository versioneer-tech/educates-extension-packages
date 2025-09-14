#!/bin/bash

PACKAGE_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")/.."; pwd)

PATH=$PACKAGE_DIR/bin:$PATH

rclone completion bash >> $HOME/.bashrc

unset PACKAGE_DIR