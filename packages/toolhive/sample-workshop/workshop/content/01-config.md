---
title: Configuration
---

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
              url: $(image_repository)/thv:v0.0.48
```
