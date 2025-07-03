---
title: Overview
---

This workshop is a sample that shows how to configure and run the
[Continue VS Code extension](https://continue.dev/).

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
              url: $(image_repository)/vscode-continue-dev:v1.1.52
```

Once the extension pack is configured in your workshop manifest,
it will be available in your editor.

You can view the installed extensions:

```editor:execute-command
command: workbench.view.extensions
```

## Preconfigure the extension
You can add configuration to this extension so that when the workshop is run
the extension already has the desired configuration.

For that you will need to add ytt overlays with the:
- AI models to use
- MCP Servers to use

For more information look at the README.md file.

Congratulations,
you now can use the extension in your Educates workshops!