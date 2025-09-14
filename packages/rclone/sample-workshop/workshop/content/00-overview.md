---
title: Overview
---

This workshop is a sample that shows how to configure and use the
Rclone Command Line Interface.

To add the Rclone Extension Package to a workshop,
add the following to the workshop manifest file (`workshop.yaml`):

```yaml
spec:
  ...
  workshop:
    ...
    packages:
      - name: rclone
        files:
          - path: .
            image:
              url: $(image_repository)/rclone:v1.71.0
```

Once the Rclone extension package is configured in your workshop manifest,
it will be installed during the workshop session startup,
placed in the `PATH`, and will have auto-completion enabled.

To verify the CLI is working, run:

```execute
rclone --version
```

You can also test auto-completion by typing `rclone ` and then pressing the `Tab` key twice.

Congratulations, you can now use the Rclone in your Educates workshops!