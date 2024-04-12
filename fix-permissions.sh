#!/bin/sh

IFS=$'\n' DIRS=( $(find packages -type d -mindepth 2 -maxdepth 2 -print) )
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