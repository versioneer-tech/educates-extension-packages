#!/bin/bash

# Usage examples:
#   # Default behavior (localhost:5001, no auth)
#   ./scripts/push-extension.sh
#
#   # With custom registry
#   ./scripts/push-extension.sh --registry ghcr.io/myorg
#
#   # With authentication
#   ./scripts/push-extension.sh --registry ghcr.io/myorg --registry-username myuser --registry-password mypass
#
#   # Publish specific package with custom registry
#   ./scripts/push-extension.sh --registry ghcr.io/myorg mypackage v1.0.0
#
#   # Publish specific package with authentication
#   ./scripts/push-extension.sh --registry ghcr.io/myorg --registry-username myuser --registry-password mypass mypackage v1.0.0

show_help() {
  cat << EOF
Usage: $0 [OPTIONS] [PACKAGE] [VERSION]

Push extension packages to a registry using imgpkg.

OPTIONS:
  --registry REGISTRY        Registry URL (default: localhost:5001)
  --registry-username USER   Registry username for authentication
  --registry-password PASS   Registry password for authentication
  -h, --help                Show this help message

ARGUMENTS:
  PACKAGE                   Package name to publish (optional, publishes all if not specified)
  VERSION                   Version to publish (required if PACKAGE is specified)

EXAMPLES:
  # Publish all packages to default registry (localhost:5001)
  $0

  # Publish all packages to custom registry
  $0 --registry ghcr.io/myorg

  # Publish specific package and version
  $0 mypackage v1.0.0

  # Publish with authentication
  $0 --registry ghcr.io/myorg --registry-username myuser --registry-password mypass mypackage v1.0.0

DESCRIPTION:
  This script publishes extension packages to a registry using imgpkg.
  It automatically runs vendir sync to fetch dependencies and applies
  permission fixes before pushing the package.

  If no PACKAGE and VERSION are provided, it publishes all packages
  found in the packages/ directory.

  The script expects packages to be organized as: packages/<package>/<version>/
EOF
}

# Default values
REGISTRY="localhost:5001"
REGISTRY_USERNAME=""
REGISTRY_PASSWORD=""

# Parse command line arguments
while [[ $# -gt 0 ]]; do
  case $1 in
    -h|--help)
      show_help
      exit 0
      ;;
    --registry)
      REGISTRY="$2"
      shift 2
      ;;
    --registry-username)
      REGISTRY_USERNAME="$2"
      shift 2
      ;;
    --registry-password)
      REGISTRY_PASSWORD="$2"
      shift 2
      ;;
    *)
      # Store non-flag arguments for package and version
      if [ -z "$PACKAGE_ARG" ]; then
        PACKAGE_ARG="$1"
      elif [ -z "$VERSION_ARG" ]; then
        VERSION_ARG="$1"
      fi
      shift
      ;;
  esac
done

publish_package() {
  PACKAGE=$1
  VERSION=$2

  if [ ! -d "packages/$PACKAGE/$VERSION" ]; then
    echo "Package directory $PACKAGE/$VERSION does not exist"
    exit 1
  fi

  echo "Syncing package $PACKAGE"
  cd packages/$PACKAGE/$VERSION
  if [[ ! -e "vendir.lock.yml" ]]; then
    echo "vendir.lock.yml not found, running vendir sync"
    vendir sync
  fi
  $PROJECT_DIR/scripts/fix-permissions.sh
  cd $PROJECT_DIR
  echo "Synced package $PACKAGE"

  echo "Pushing package $PACKAGE/$VERSION into $REGISTRY/$PACKAGE:$VERSION"
  
  # Build imgpkg push command
  IMGPKG_CMD="imgpkg push -i $REGISTRY/$PACKAGE:$VERSION -f $PROJECT_DIR/packages/$PACKAGE/$VERSION --file-exclusion vendir.yml --file-exclusion vendir.lock.yml"
  
  # Add registry authentication if provided
  if [ ! -z "$REGISTRY_USERNAME" ] && [ ! -z "$REGISTRY_PASSWORD" ]; then
    IMGPKG_CMD="$IMGPKG_CMD --registry-username=$REGISTRY_USERNAME --registry-password=$REGISTRY_PASSWORD"
  fi
  
  eval $IMGPKG_CMD
}

publish_all_packages() {
  PACKAGE_DIRS=$(find packages -mindepth 1 -maxdepth 1 -type d -print)
  for PACKAGE_DIR in ${PACKAGE_DIRS[@]}; do
    VERSION_DIRS=$(find $PACKAGE_DIR/v* -mindepth 0 -maxdepth 0 -type d -print)
    for VERSION_DIR in ${VERSION_DIRS[@]}; do
      PACKAGE=$(basename $PACKAGE_DIR)
      VERSION=$(echo $VERSION_DIR | cut -d/ -f3)
      echo "Publishing package $PACKAGE/$VERSION from $VERSION_DIR"
      publish_package $PACKAGE $VERSION
    done
  done
}

# Make sure this runs from root of the project, where the packages directory is present
if [ ! -d "packages" ]; then
  echo "Run this script from the root of the project, where the packages directory is present"
  exit 1
fi

PROJECT_DIR=$(pwd)

if [ -z "$PACKAGE_ARG" ] && [ -z "$VERSION_ARG" ]; then
  echo "Publishing all packages..."
  publish_all_packages
  echo "Done publishing all packages"
elif [ ! -z "$PACKAGE_ARG" ] && [ -z "$VERSION_ARG" ]; then
  echo "Missing version"
  exit 1
else
  echo "Publishing package $PACKAGE_ARG:$VERSION_ARG..."
  publish_package $PACKAGE_ARG $VERSION_ARG
  echo "Done publishing package $PACKAGE_ARG:$VERSION_ARG"
fi
