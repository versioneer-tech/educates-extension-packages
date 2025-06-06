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
      - name: educates
        files:
          - path: .
            image:
              url: $(image_repository)/educates:v3.3.2
```
