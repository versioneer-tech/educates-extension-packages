# educates extension packages

This repository serve as an example of how to create your own extension packages.

There's currently a few extensions in this repo:

- educates (versions 3.0.1, 3.1.0, 3.2.2 and 3.3.2)
- argocd (version 2.10.6)
- crane (version 0.19.1)

There's no binaries in this repo, but the [GH action](.github/workflows/publish-packages.yaml) will fetch them using
the provided [vendir.yml](./vendir.yml) configuration.

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
