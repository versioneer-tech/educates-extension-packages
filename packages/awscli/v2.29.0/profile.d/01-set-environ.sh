#!/bin/bash

if ! command -v aws >/dev/null 2>&1; then
    return
fi

complete -C aws_completer aws