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
or, installing through code-server during the session startup,
The extensions are staged during build time as a file overlay.

During the session startup (`setup.d`),
the files are copied over to the `code-server` `extensions` directory.

This is significantly faster than relying on `code-server` installation
of VS code extensions.

## Why this extension over vscode-java-tools?

The `vscode-java-tools` extension package uses `code-server --install-extension`
command for each of the 7 VS code extensions during the workshop session
startup time (`setup.d`) from the extension package `*.vsix` files.

While this keeps decoupling for market places access and/or rate limiting,
it still takes between 10-15 seconds for installing the Java extensions.

The `vscode-java-tools-oci-overlay` method takes the optimization a step
further by exploding the extension file directory, including the extension manifest,
into the extension package,
and is merely copied/merged to the `code-server` extensions directory,
which is nearly zero time overhead.

## Tradeoffs

When comparing the approaches between this extension package and the
`vscode-java-tools` package, you will notice the level of precision required to stage and
declare the exploded extension directory and manifest.

There may be other issues given that `code-server`will be running before the extension package
setup is run, and also that code-server does not officially endorse this method of installing extensions.
Use at your own risk, and factor in sufficient testing.

Also notice that the `vscode-java-tools` extension package uses the `code-server --install-extension`,
that is a supported method of installing extensions.

## Known issues

The extension package is verified to work with Java projects using Maven builds.
It has a bug with gradle builds, in that the VS code editor gradle daemons will not start,
and an error is shown during the editor startup time.
