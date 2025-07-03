# README

This extension package includes [Continue.dev VS Code Extension](https://www.continue.dev/).

With the extension package, you get:

- The ability to create, share, and use custom AI code assistants 

## Using it

You can apply this extension package following the instructions from
[Educates documentation](https://docs.educates.dev/en/stable/custom-resources/workshop-definition.html#adding-extension-packages).

The following is a sample snippet.
Make sure you are specifying one of the versions in this folder.

```yaml
spec:
  workshop:
    ...
    packages:
    - name: vscode-continue
      files:
      - image:
          url: ghcr.io/educates/educates-extension-packages/vscode-continue-dev:v1.1.52
```