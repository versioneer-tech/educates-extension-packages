# README

This extension package includes an aggregate set of VS Code extensions associated with Microsoft's [Extension Pack for Java](https://marketplace.visualstudio.com/items?itemName=vscjava.vscode-java-pack),
along with common VS code settings used in Java projects.

With the extension package,
you get:

- Java language server, intellisense
- Ability to run, debug and test Java apps from the code editor
- Ability to build, test Java apps using Maven or Gradle build tools.

## Version

The version of the Educates supplied extension package matches that of the
[Extension Pack for Java](https://marketplace.visualstudio.com/items?itemName=vscjava.vscode-java-pack).

## Using it

You can apply this extension package following the instructions from
[Educates documentation](https://docs.educates.dev/en/stable/custom-resources/workshop-definition.html#adding-extension-packages).

The following is a sample snippet.
Make sure you are running on a `jdk*-environment` base image,
and also that you are specifying one of the versions in this folder.

```yaml
spec:
  workshop:
    image: jdk17-environment:* # jdk*-environment:*
    ...
    packages:
    - name: tce
      files:
      - image:
          url: ghcr.io/educates/educates-extension-packages/vscode-java-tools-oci-overlay:v0.29.2
```

## How it works

Rather than having the user manually install the Java Extension Pack,
or, the Java pack extensions are installed during the session start up time (`setup.d`)
using `code-server --install-extensions` command.
The `*.vsix` marketplace files are provided as part of the extension package
to reduce coupling to the marketplace, both in latency, and potential rate limiting.

OCI caching in Educates can also improve download performance.

Note that there is ~10-15 second overhead on the session startup,
but is still significantly faster that install.

You can checkout the `vscode-java-tools-oci-overlay` extension package as an
example for how to speed up the Java extension installations.
