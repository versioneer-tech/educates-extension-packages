# Educates Extension Packages

This repository services as a collection of reference implementations of common
uses of Educates extension packages.

You can any of them directly,
or as examples of how to create your own.

The following are list of current extension packages,
located under the `package` directory

whitelisted:
- [awscli](packages/awscli/)

not whitelisted:
- [educates](packages/educates/)
- [argocd](packages/argocd/)
- [crane](packages/crane/)
- [toolhive from Stacklok](packages/toolhive/)
- [github](packages/github/)
- [vscode-java-tools](packages/vscode-java-tools/)
- [vscode-java-tools-oci-overlay](packages/vscode-java-tools-oci-overlay/)
- [vscode-roo-code](packages/vscode-roo-code/)
- [vscode-continue-dev](packages/vscode-continue-dev/)

The current Extension Package build system assumes you will be downloading external
resources using `vendir`, then injecting and staging the resources from the extension package
into a workshop session using the `setup.d` hooks.

You can also use the `push-extension.sh` command to develop locally.

There are no binaries in this repo, but the [GH action](.github/workflows/publish-packages.yaml) will fetch them using
the provided [vendir.yml](./vendir.yml) configurations.

## Using the extensions

Add to your workshop:

```
apiVersion: training.educates.dev/v1beta1
kind: Workshop
metadata:
  name: "your-workshop"
spec:
  ...
  workshop:
    files:
      - image:
          url: $(image_repository)/your-workshop-files:$(workshop_version)
        path: .
    packages:
      - name: argocd
        files:
          - path: .
            image:
              url: ghcr.io/educates/educates-extension-packages/argocd:v2.10.6
  ...
```

Note that typically you would cache the extension images locally to speed up the process. For that you can use `Educates`
built in [OCI image cache functionality](https://docs.educates.dev/custom-resources/workshop-definition#shared-oci-image-cache),
in that case, replace the extension package image reference.

```
apiVersion: training.educates.dev/v1beta1
kind: Workshop
metadata:
  name: "your-workshop"
spec:
  ...
  workshop:
    files:
      - image:
          url: $(image_repository)/your-workshop-files:$(workshop_version)
        path: .
    packages:
      - name: argocd
        files:
          - path: .
            image:
              url: $(oci_image_cache)/argocd:v2.10.6
  ...
```

This feature, makes the url of the extension on the previous snippet different than if you were to fetch the upstream
extension `ghcr.io/educates/educates-extension-packages/argocd:v2.10.6` but the one from the cache `$(oci_image_cache)/argocd:v2.10.6`

```
  ...
  environment:
    images:
      registries:
        - content:
            - destination: argocd
              prefix: /educates/educates-extension-packages/argocd
              stripPrefix: true
          onDemand: true
          urls:
            - https://ghcr.io
  ...
```

## Developing, building and publishing locally

If you have a local Educates cluster running,
you can publish the extension packages to your local cluster with the
`scripts/push-extension.sh` script.

Make sure you have the `KUBECONFIG` set in your terminal session to point to your local cluster,
so the `educates` cli can talk to it.

You can use this also if you want to fork and develop your own extensions.

The `push-extension.sh` script also allows you to publish a single extension package version.
This simplifies inner loop development flow:

From the project root directory, run the following:

```bash
# Default behavior (localhost:5001, no auth)
./scripts/push-extension.sh

# Publish specific package and version
./scripts/push-extension.sh <package> <version>

# With custom registry
./scripts/push-extension.sh --registry ghcr.io/myorg <package> <version>

# With authentication
./scripts/push-extension.sh --registry ghcr.io/myorg --registry-username myuser --registry-password mypass <package> <version>
```

where the package and version has a sub-directory tree under the `packages` directory:

`packages/<package>/<version>`

For example, if wanting to publish the `argocd:v2.10.6` package locally, run the following:

```bash
./scripts/push-extension.sh argocd v2.10.6
```

Or with a custom registry:

```bash
./scripts/push-extension.sh --registry ghcr.io/myorg argocd v2.10.6
```

### Extension Package source structure

If you want to build your own extension packages,
follow the same pattern as the others:

```no-highlight
packages/some-new-package
├── README.md
├── sample-workshop
│   ├── resources
│   │   └── workshop.yaml
│   └── workshop
│       ├── config.yaml
│       └── content
│           ├── 00-overview.md
│           ├── 01-config.md
│           ├── 10-using.md
│           └── 99-summary.md
└── v0.0.1
    ├── profile.d
    │   └── 01-set-environ.sh
    ├── setup.d
    │   └── 01-setup.sh
    └── vendir.yml
  ```

### Steps to build and publish an new extension package locally

1.  Create a new package directory (for example `some-new-package ).
2.  Create a new version sub-directory under the package directory (for example `v0.0.1`).
    Make sure the version is prefixed with `v*`, that is important for publishing.
3.  Build a `vendir.yml` configuration that downloads the files for the specific version
    of the package, and put it in the version subdirectory.
4.  Create workshop setup scripts to inject and stage the files from the extension package
    into the workshop session file system:
    - `profile.d/01-set-environ.sh` - Setup your environment variables here.
    - `setup.d/01-setup-<optional suffix>.sh` - Setup the injecting and staging behavior here.
5.  Create a `sample-workshop` that serves as an acceptance test and/or instructions how
    to configure and install the extension package.

You can review the existing `vendir.yml`, setup scripts and sample workshops for examples and inspiration.

## Sample workshops

Each of the extension packages have an accompanying sample workshop
that demonstrate how to configure and use the extension package features.

If you want to publish and deploy the workshops locally,
run the `./scripts/push-extension.sh` first to publish the extension packages locally,
then run the `./scripts/publish-and-deploy-workshops.sh` convenience script locally.

It will publish, deploy, and open a browser window to the training portal dashboard
with all the sample workshops.

You can also publish and deploy a specific workshop by providing the package name:

```bash
# Publish and deploy all workshops (default)
./scripts/publish-and-deploy-workshops.sh

# Publish and deploy only the argocd workshop
./scripts/publish-and-deploy-workshops.sh argocd

# Publish and deploy only the educates workshop
./scripts/publish-and-deploy-workshops.sh educates
```
