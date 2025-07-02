#!/bin/bash

set -x
set -eo pipefail

PACKAGE_DIR=$(cd "$(dirname $BASH_SOURCE)/.."; pwd)

# Install extensions
# Compute the complete time it takes to install the extensions
start_time=$(date +%s)
mkdir -p ~/.local/share/code-server/extensions/

# Remove the platform specific extensions not applicable to the current platform
if [[ "$PLATFORM_TYPE" == "amd64" ]]; then
  rm -rf $PACKAGE_DIR/extensions/redhat.java-arm64-1.42.0
  mv $PACKAGE_DIR/extensions/redhat.java-amd64-1.42.0 $PACKAGE_DIR/extensions/redhat.java-1.42.0
else
  rm -rf $PACKAGE_DIR/extensions/redhat.java-amd64-1.42.0
  mv $PACKAGE_DIR/extensions/redhat.java-arm64-1.42.0 $PACKAGE_DIR/extensions/redhat.java-1.42.0
fi

# Move the extension from
for extension in `ls $PACKAGE_DIR/bin/`
do
  extension_name=$(basename $extension)
  cp -r $PACKAGE_DIR/bin/$extension_name/extension ~/.local/share/code-server/extensions/$extension_name
done
end_time=$(date +%s)
elapsed_time=$((end_time - start_time)):
echo "Time taken to install extensions: $elapsed_time seconds"

# Stage the vscode java settings updates
cp -r $PACKAGE_DIR/settings.json ~/.local/share/code-server/User/settings.json
# Copy and merge the extensions.json file into the existing extensions.json file
EXTENSIONS_JSON_FILE="$HOME/.local/share/code-server/extensions/extensions.json"
if [[ -e "$EXTENSIONS_JSON_FILE" ]]; then
    jq -s '.[0] + .[1]' $EXTENSIONS_JSON_FILE $PACKAGE_DIR/extensions.json > $EXTENSIONS_JSON_FILE.tmp
    mv $EXTENSIONS_JSON_FILE.tmp $EXTENSIONS_JSON_FILE
else
    cp -r $PACKAGE_DIR/extensions.json $EXTENSIONS_JSON_FILE
fi

unset PACKAGE_DIR
