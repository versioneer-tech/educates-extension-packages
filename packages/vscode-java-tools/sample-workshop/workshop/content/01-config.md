---
title: Configuration
---

To add the VS Code Java Tools Educates Extension Package to a workshop,
merely add the following excerpt to the workshop manifest file,
or `workshop.yaml` file:

```yaml
spec:
  ...
  workshop:
    ...
    packages:
      - name: vscode-java-tools
        files:
          - path: .
            image:
              url: $(image_repository)/vscode-java-tools:v0.29.2
```
