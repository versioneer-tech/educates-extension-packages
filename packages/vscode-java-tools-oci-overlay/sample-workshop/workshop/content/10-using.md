---
title: Using it
---

To use the [Extension Pack for Java](https://marketplace.visualstudio.com/items?itemName=vscjava.vscode-java-pack),
all you need is a Java codebase that you have imported into workshop content and/or
workshop session codespace.

This workshop embeds a Java codebase into the `exercises` directory as part of the
workshop content.

It is common practice to include the build tool along with your codebase.

Support for Gradle and Maven are included.

The included exercise here includes Maven.

To activate the extension,
just navigate to the code editor:

```editor:open-file
file: ~/exercises/pom.xml
```

It defaults to load the project in the `exercises` directory,
will detect that it is a Java project with maven build tool,
and load and activate the project view, test running, and
maven build views.
