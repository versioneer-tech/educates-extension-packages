# Workshop

This workshop demonstrates a simple Java development
environment using Maven.

You will need to publish and deploy the workshop to verify it.

## Prerequisites

-   You have access to publish/deploy to an Educates cluster with `kubectl` access.

-   Make sure `KUBECONFIG` is set in your environment pointing to your Educates
    cluster before running the `educates` CLI commands.

-   Make sure the extension package is published,
    (or you can reference the educates public package as is in the `workshop.yaml` files).

## Publish

From the Educates Extension Packages project root,
run:

`educates publish-workshop packages/vscode-java-tools-oci-overlay/v0.29.2/test-workshops/test-maven-workshop/`

## Deploy

From the Educates Extension Packages project root,
run:

`educates deploy-workshop -f packages/vscode-java-tools-oci-overlay/v0.29.2/test-workshops/test-maven-workshop/resources/workshop.yaml`

## Post the training portal dashboard

From the Educates Extension Packages project root,
run:

`educates browse-workshops`

If this is the first time you are viewing the training portal for a development environment,
you may be prompted for a portal password.
You can view the password:

`educates view-credentials`

If you are prompted for user name and password,
view the training portal admin credentials at:

`kubectl get trainingportals.training.educates.dev`

Or, talk to your Educates/K8s administrator.

You can then launch and test your workshop.
