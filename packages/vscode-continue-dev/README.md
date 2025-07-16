# README

This extension package includes [Continue.dev VS Code Extension](https://www.continue.dev/).

With the extension package, you get:

- The ability to create, share, and use custom AI code assistants 

## Using it

You can apply this extension package following the instructions from
[Educates documentation](https://docs.educates.dev/en/stable/custom-resources/workshop-definition.html#adding-extension-packages).

The following is a sample snippet.
Make sure you are specifying one of the versions in this folder.

```yaml
spec:
  workshop:
    ...
    packages:
    - name: vscode-continue
      files:
      - image:
          url: ghcr.io/educates/educates-extension-packages/vscode-continue-dev:v1.1.52
```

## Configure the extension

This extension can be configured in a global manner. The extension provides hooks
so that when configuration files (models and mcpservers) are provided to the container, 
they will be merged with the continue config.

For that, create a secret with the following contents for models:

```
apiVersion: v1
kind: Secret
metadata:
  name: continue-config-models
  namespace: default
type: Opaque
stringData:
  litellm-educates-model.yaml: |
    #@ load("@ytt:overlay", "overlay")

    #@overlay/match by=overlay.all
    ---
    models:
    #@overlay/match by="name",expects="0+"
    - name: LiteLLM
      provider: openai
      model: gemini/gemini-2.5-flash
      apiBase: http://litellm.litellm.svc.cluster.local:4000
      apiKey: sk-5678
      roles:
        - chat
        - edit
        - apply
  deepseek-educates-model.yaml: |
    #@ load("@ytt:overlay", "overlay")

    #@overlay/match by=overlay.all
    ---
    models:
    #@overlay/match by="name",expects="0+"
    - name: deepseek
      provider: ollama
      model: tom_himanen/deepseek-r1-roo-cline-tools:8b
      apiBase: http://ollama.ollama.svc.cluster.local:11434
```

And a similar secret with ytt overlays for mcpServers:
```
apiVersion: v1
kind: Secret
metadata:
  name: continue-config-servers
  namespace: default
type: Opaque
stringData:
  mcp-servers.yaml: |
    #@ load("@ytt:overlay", "overlay")

    ---
    name: Educates MCP Server Configuration
    version: 0.0.1
    schema: v1
    mcpServers:

    #@overlay/match by=overlay.all
    ---
    mcpServers:
    #@overlay/match by="name",expects="0+"
    - name: fetch
      type: streamable-http
      url:  http://127.0.0.1:36648/mcp
```

Then, you will need to add these secrets to your workshop like this:

```
...
  session:
    ...
    volumes:
      - name: continue-config-models
        secret:
          secretName: continue-config-models
      - name: continue-config-mcpservers
        secret:
          secretName: continue-config-mcpservers
    volumeMounts:
      - name: continue-config-models
        mountPath: /opt/continue/config/models/
        readOnly: true
      - name: continue-config-mcpservers
        mountPath: /opt/continue/config/mcpservers/
        readOnly: true
  environment:
    secrets:
    - name: continue-config-models
      namespace: default
    - name: continue-config-mcpservers
      namespace: default
```

This will mount the secrets in the appropriate locations for the [setup script](v1.1.52/setup.d/02-apply-config-if-exists.sh) to configure the extension.

## Try for yourself

The [test workshop](sample-workshop/) is ready to be used, but you need to apply these secrets:

```
kubectl apply -f sample-workshop/k8s/
```

This will create the secrets and you will be able to validate that the configruation has been applied,
even if the extension doesn't work because of the models and mcpServers not being available to the 
test workshop.