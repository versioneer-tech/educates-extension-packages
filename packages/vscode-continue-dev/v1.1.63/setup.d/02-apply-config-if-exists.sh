#!/bin/bash

set -x
set -eo pipefail

PACKAGE_DIR=$(cd "$(dirname $BASH_SOURCE)/.."; pwd)

# You will need to mount config files into this directory for them to be applied
MODELS_CONFIG_DIR=/opt/continue/config/models
MCPSERVERS_CONFIG_DIR=/opt/continue/config/mcpservers

# Make sure this directory exists
mkdir -p ~/.continue/
mkdir -p ~/.continue/mcpServers/

# Process config updates via ytt
# This will merge the existing config with the overlay for models
if [ ! -e $MODELS_CONFIG_DIR ]; then
  echo "Error: $MODELS_CONFIG_DIR does not exist. No models will be configured."
else
  # We need to use the ..data directory as the config directory is symlinked to the timestamped directory of the mounted secret
  ytt -f $PACKAGE_DIR/default-config.yaml -f $MODELS_CONFIG_DIR/..data/ > ~/.continue/config.yaml || true
  echo "Updated ~/.continue/config.yaml with overlay"
fi

# This will merge the existing config with the overlay for mcp servers
if [ ! -e $MCPSERVERS_CONFIG_DIR ]; then
  echo "Error: $MCPSERVERS_CONFIG_DIR does not exist. No mcp servers will be configured."
else
  # We need to use the ..data directory as the config directory is symlinked to the timestamped directory of the mounted secret
  ytt -f $MCPSERVERS_CONFIG_DIR/..data/ > ~/.continue/mcpServers/educates-mcp-servers.yaml || true
  echo "Updated ~/.continue/mcpServers/educates-mcp-servers.yaml with overlay"
fi

unset MODELS_CONFIG_DIR
unset MCPSERVERS_CONFIG_DIR
unset PACKAGE_DIR