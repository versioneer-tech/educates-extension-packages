---
title: Configure and use Toolhive in an Educates workshops
---

This workshop is a sample that shows how to configure and run the
[Toolhive](https://github.com/stacklok/toolhive) CLI.

## Configuration
To add the Educates CLI Extension Package to a workshop,
merely add the following excerpt to the workshop manifest file,
or `workshop.yaml` file:

```yaml
spec:
  ...
  workshop:
    ...
    packages:
      - name: toolhive
        files:
          - path: .
            image:
              url: $(image_repository)/toolhive:v0.1.7
```

## Usage

Once the Toolhive CLI `thv` extension pack is configured in your workshop manifest,
it will be injected and staged into your workshop session during its start up,
placed in the PATH, and with auto-completion enabled.

To verify the CLI functions correctly,

```execute
thv version
```

For bonus points,
try out autocomplete by typing the partial `thv` command and `version` subcommand.

## Summary

Congratulations, you now can use the Toolhive CLI in your Educates workshops.