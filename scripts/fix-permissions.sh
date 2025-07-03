#!/bin/bash

# Usage examples:
#   # Fix permissions in current directory (default behavior)
#   ./scripts/fix-permissions.sh
#
#   # Show help information
#   ./scripts/fix-permissions.sh --help

show_help() {
  cat << EOF
Usage: $0 [OPTIONS]

Fix execute permissions for binary files in the bin directory.

OPTIONS:
  -h, --help                Show this help message

DESCRIPTION:
  This script changes the permissions of all ELF binary files in the bin directory
  to executable (755). It is designed to be run after vendir sync operations to
  ensure that downloaded binaries have the correct execute permissions.

  The script:
  1. Checks if a bin directory exists in the current working directory
  2. Searches for all files in the bin directory
  3. Identifies ELF binary files using the 'file' command
  4. Changes their permissions to 755 (rwxr-xr-x)

  If no bin directory is found, the script exits successfully (exit code 0)
  without making any changes.

  This script is typically called by other scripts (like push-extension.sh)
  after vendir sync operations to ensure binaries are executable.

EXAMPLES:
  # Fix permissions in current directory
  $0

  # Show help
  $0 --help

PREREQUISITES:
  - Must be run from a directory where vendir has created a bin directory
  - The 'file' command must be available to identify ELF binaries
  - Typically run after vendir sync operations

NOTES:
  - This script is designed to fail gracefully and not break builds
  - For VSCode extensions, the bin directory is typically not present, so the script will exit cleanly
  - The script uses 'set +e' to allow failures without stopping execution
EOF
}

# Parse command line arguments
while [[ $# -gt 0 ]]; do
  case $1 in
    -h|--help)
      show_help
      exit 0
      ;;
    *)
      echo "Unknown option: $1"
      echo "Use --help for usage information"
      exit 1
      ;;
  esac
done

# Allow this script to fail without failing a build
set +e

# This script changes the permissions of all binaries in the bin directory for execute permissions.
# It assumes to run in a given package directory of the project, where vendir is run, and the vendir
# output bin directory is present.
# For vscode extensions, the bin directory is not present, so we skip it.

if [ ! -d "bin" ]; then
  echo "No bin directory found in $(pwd), skipping permission fixes"
  exit 0
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