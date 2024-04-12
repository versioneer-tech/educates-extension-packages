#!/bin/bash

# Allow this script to fail without failing a build
set +e

DIRS=$(find packages -mindepth 2 -maxdepth 2 -type d -print)
for DIR in ${DIRS[@]}; do
   # For every file in this directory
   for FILE in $(find $DIR -type f); do
      # If the file is a binary
      if file $FILE | grep -q "ELF"; then
         # Change permissions of the binary
         chmod 755 $FILE
      fi
   done
done