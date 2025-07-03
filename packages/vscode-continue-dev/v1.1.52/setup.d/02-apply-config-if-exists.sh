#!/bin/bash

set -x
set -eo pipefail

PACKAGE_DIR=$(cd "$(dirname $BASH_SOURCE)/.."; pwd)
# You will need to mount config files into this directory for them to be applied
PACKAGE_CONFIG_DIR=/opt/litellm/config/

# Make sure this directory exists
mkdir -p ~/.continue/
# Save previous copy of config.yaml as backup if it exists
mv ~/.continue/config.yaml ~/.continue/config.yaml.bak || true
# Process config updates via ytt
# This will merge the existing config with the overlay
if [ ! -e $PACKAGE_CONFIG_DIR ]; then
  echo "Error: $PACKAGE_CONFIG_DIR does not exist. No configuration will be applied."
else
  ytt -f $PACKAGE_DIR/default-config.yaml -f $PACKAGE_CONFIG_DIR --allow-symlink-destination  $PACKAGE_CONFIG_DIR > ~/.continue/config.yaml
  echo "Updated ~/.continue/config.yaml with overlay"
fi

unset PACKAGE_CONFIG_DIR
unset PACKAGE_DIR