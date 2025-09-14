---
title: Overview
---

This workshop is a sample that shows how to configure and use the
AWS Command Line Interface (CLI).

To add the AWS CLI Extension Package to a workshop,
add the following to the workshop manifest file (`workshop.yaml`):

```yaml
spec:
  ...
  workshop:
    ...
    packages:
      - name: awscli
        files:
          - path: .
            image:
              url: $(image_repository)/awscli:v2.29.0
```

Once the AWS CLI extension package is configured in your workshop manifest,
it will be installed during the workshop session startup,
placed in the `PATH`, and will have auto-completion enabled.

To verify the CLI is working, run:

```execute
aws --version
```

You can also test auto-completion by typing `aws ` and then pressing the `Tab` key twice.

Congratulations, you can now use the AWS CLI in your Educates workshops!