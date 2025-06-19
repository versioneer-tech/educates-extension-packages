---
title: Configuration
---

To add the ArgoCD CLI Extension Package to a workshop,
merely add the following excerpt to the workshop manifest file,
or `workshop.yaml` file:

```yaml
spec:
  ...
  workshop:
    ...
    packages:
      - name: argocd
        files:
          - path: .
            image:
              url: $(image_repository)/argocd:v2.10.6
```
