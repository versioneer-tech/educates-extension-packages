# Rclone Command Line Interface

This extension package adds the `rclone` CLI to your Educates workshop.

See the Rclone project for more information.

## Using it

You can add this extension package to your workshop by adding the following snippet to your `workshop.yaml` file:

```yaml
spec:
  workshop:
    ...
    packages:
    - name: rclone
      files:
      - path: .
        image:
          url: ghcr.io/versioneer-tech/educates-extension-packages/rclone:v1.71.0
```

**NOTE:** Currently only AMD64 variant is supported via this extension package.