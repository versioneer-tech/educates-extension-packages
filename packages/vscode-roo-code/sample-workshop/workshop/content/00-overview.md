---
title: Overview
---

This workshop is a sample that shows how to configure and run the
[Roo Code VS Code extension](https://roocode.com/).

To add the extension package to a workshop,
merely add the following excerpt to the workshop manifest file,
or `workshop.yaml` file:

```yaml
spec:
  ...
  workshop:
    ...
    packages:
      - name: vscode-roo-code
        files:
          - path: .
            image:
              url: $(image_repository)/vscode-roo-code:v3.22.5
```

Once the extension pack is configured in your workshop manifest,
it will be available in your editor.

You can view the installed extensions:

```editor:execute-command
command: workbench.view.extensions
```

Congratulations,
you now can use the extension in your Educates workshops!