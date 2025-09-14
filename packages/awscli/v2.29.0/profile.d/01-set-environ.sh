#!/bin/bash

# Setup AWS CLI autocompletion
if ! command -v aws >/dev/null 2>&1; then
    return
fi

complete -C '/usr/local/bin/aws_completer' aws