#!/bin/bash

# Usage examples:
#   # Publish and deploy all workshops (default behavior)
#   ./scripts/publish-and-deploy-workshops.sh
#
#   # Publish and deploy only the argocd workshop
#   ./scripts/publish-and-deploy-workshops.sh argocd
#
#   # Publish and deploy only the educates workshop
#   ./scripts/publish-and-deploy-workshops.sh educates

show_help() {
  cat << EOF
Usage: $0 [OPTIONS] [PACKAGE]

Publish and deploy Educates workshops locally.

OPTIONS:
  -h, --help                Show this help message

ARGUMENTS:
  PACKAGE                   Package name to publish and deploy (optional, processes all if not specified)

EXAMPLES:
  # Publish and deploy all workshops (default)
  $0

  # Publish and deploy only the argocd workshop
  $0 argocd

  # Publish and deploy only the educates workshop
  $0 educates

DESCRIPTION:
  This script publishes and deploys Educates workshops to your local cluster.
  It uses the educates CLI to publish workshop content and deploy workshop
  resources to your Kubernetes cluster.

  If no PACKAGE is provided, it processes all packages that have a
  sample-workshop directory.

  The script expects workshops to be organized as: packages/<package>/sample-workshop/

  After publishing and deploying, it automatically opens a browser window
  to browse the available workshops.

PREREQUISITES:
  - educates CLI must be installed and configured
  - KUBECONFIG must be set to point to your local cluster
  - Extension packages should be published locally first using push-extension.sh
EOF
}

# Parse command line arguments
PACKAGE_ARG=""
while [[ $# -gt 0 ]]; do
  case $1 in
    -h|--help)
      show_help
      exit 0
      ;;
    *)
      if [ -z "$PACKAGE_ARG" ]; then
        PACKAGE_ARG="$1"
      fi
      shift
      ;;
  esac
done

publish_and_deploy_workshop() {
  PACKAGE=$1
  
  if [ ! -d "packages/$PACKAGE/sample-workshop" ]; then
    echo "Sample workshop directory for package $PACKAGE does not exist"
    return 1
  fi
  
  echo "Publishing workshop for package $PACKAGE"
  educates publish-workshop ./packages/$PACKAGE/sample-workshop
  
  echo "Deploying workshop for package $PACKAGE"
  educates deploy-workshop -f ./packages/$PACKAGE/sample-workshop/resources/workshop.yaml
}

publish_and_deploy_all_workshops() {
  PACKAGE_DIRS=$(find packages -mindepth 1 -maxdepth 1 -type d -print)
  for PACKAGE_DIR in ${PACKAGE_DIRS[@]}; do
    PACKAGE=$(basename $PACKAGE_DIR)
    if [ -d "packages/$PACKAGE/sample-workshop" ]; then
      echo "Processing workshop for package $PACKAGE"
      publish_and_deploy_workshop $PACKAGE
    else
      echo "No sample workshop found for package $PACKAGE, skipping"
    fi
  done
}

# Make sure this runs from root of the project, where the packages directory is present
if [ ! -d "packages" ]; then
  echo "Run this script from the root of the project, where the packages directory is present"
  exit 1
fi

if [ -z "$PACKAGE_ARG" ]; then
  echo "Publishing and deploying all workshops..."
  publish_and_deploy_all_workshops
  echo "Done publishing and deploying all workshops"
else
  # Validate that the package directory exists
  if [ ! -d "packages/$PACKAGE_ARG" ]; then
    echo "Error: Package '$PACKAGE_ARG' does not exist in the packages directory"
    echo "Available packages:"
    ls -1 packages/ 2>/dev/null | sed 's/^/  - /' || echo "  No packages found"
    exit 1
  fi
  
  echo "Publishing and deploying workshop for package $PACKAGE_ARG..."
  publish_and_deploy_workshop $PACKAGE_ARG
  echo "Done publishing and deploying workshop for package $PACKAGE_ARG"
fi

echo "Opening browser to browse workshops..."
educates browse-workshops
