# AWS Command Line Interface

This extension package adds the `aws` CLI to your Educates workshop.

See the AWS Command Line Interface project for more information.

## Using it

You can add this extension package to your workshop by adding the following snippet to your `workshop.yaml` file:

```yaml
spec:
  workshop:
    ...
    packages:
    - name: awscli
      files:
      - path: .
        image:
          url: ghcr.io/versioneer-tech/educates-extension-packages/awscli:v2.29.0
```

**NOTE:** Currently only AMD64 variant is supported via this extension package.