#!/bin/bash
# Allow this script to fail without failing a build
set +e

# This script changes the permissions of all binaries in the bin directory for execute permissions.
# It assumes to run in a given package directory of the project, where vendir is run, and the vendir
# output bin directory is present.

if [ ! -d "bin" ]; then
  echo "Run this script where the bin directory is present"
  exit 1
fi

DIRS=$(find bin -mindepth 0 -maxdepth 0 -type d -print)
echo "Found directories where to fix permissions: $DIRS, from $(pwd)"
for DIR in ${DIRS[@]}; do
   for FILE in $(find $DIR -type f); do
      if file $FILE | grep -q "ELF"; then
         # Change permissions of the binary
         echo "Changing permissions of $FILE to 755"
         chmod 755 $FILE
      fi
   done
done