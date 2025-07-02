#!/bin/bash

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

  echo "Pushing package $PACKAGE/$VERSION into localhost:5001/$PACKAGE:$VERSION"
  imgpkg push -i localhost:5001/$PACKAGE:$VERSION -f $PROJECT_DIR/packages/$PACKAGE/$VERSION --file-exclusion vendir.yml --file-exclusion vendir.lock.yml
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

if [ -z "$1" ] && [ -z "$2" ]; then
  echo "Publishing all packages..."
  publish_all_packages
  echo "Done publishing all packages"
elif [ ! -z "$1" ] && [ -z "$2" ]; then
  echo "Missing version"
  exit 1
else
  echo "Publishing package $1:$2..."
  publish_package $1 $2
  echo "Done publishing package $1:$2"
fi
