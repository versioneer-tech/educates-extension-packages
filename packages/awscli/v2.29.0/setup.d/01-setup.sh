#!/bin/bash

set -x
set -e

unzip /opt/packages/awscli/vendir/awscli-exe-linux-x86_64-*.zip -d /tmp
/tmp/aws/install
rm -rf /tmp/aws