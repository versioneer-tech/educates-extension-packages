---
title: Instructions
---

This workshop is a sample that shows how to configure and run the
[GitHub](https://github.com/cli/cli) CLI.

To add the GitHub CLI Extension Package to a workshop,
merely add the following excerpt to the workshop manifest file,
or `workshop.yaml` file:

```yaml
spec:
  ...
  workshop:
    ...
    packages:
      - name: github
        files:
          - path: .
            image:
              url: $(image_repository)/github:v2.74.2
```

Once the GitHub CLI extension pack is configured in your workshop manifest,
it will be injected and staged into your workshop session during its start up,
placed in the PATH, and with auto-completion enabled.

To verify the CLI functions correctly,

```execute
GitHub version
```

For bonus points,
try out autocomplete by typing the partial `gh` command and `--version` flag.

Congratulations,
you now can use the GitHub CLI in your Educates workshops!