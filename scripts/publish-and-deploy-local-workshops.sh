#!/bin/bash

# Publish and Test Workshops

## Assumed extensions are published locally

## Publish Workshops

educates publish-workshop ./packages/argocd/sample-workshop
educates publish-workshop ./packages/crane/sample-workshop
educates publish-workshop ./packages/educates/sample-workshop
educates publish-workshop ./packages/vscode-java-tools/sample-workshop
educates publish-workshop ./packages/vscode-java-tools-oci-overlay/sample-workshop

## Deploy Workshops

educates deploy-workshop -f ./packages/argocd/sample-workshop/resources/workshop.yaml
educates deploy-workshop -f ./packages/crane/sample-workshop/resources/workshop.yaml
educates deploy-workshop -f ./packages/educates/sample-workshop/resources/workshop.yaml
educates deploy-workshop -f ./packages/vscode-java-tools/sample-workshop/resources/workshop.yaml
educates deploy-workshop -f ./packages/vscode-java-tools-oci-overlay/sample-workshop/resources/workshop.yaml

## Browse Workshops

educates browse-workshops
