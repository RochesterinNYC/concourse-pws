#!/bin/bash

set -eux

curl -L https://github.com/concourse/concourse/releases/download/v1.1.0/concourse_linux_amd64 -o concourse
chmod +x concourse

sudo ./concourse worker \
  --work-dir /home/vcap/app \
  --tsa-host http://concourse-pws.cfapps.io/ \
  --tsa-port 7777 \
  --tsa-public-key keys/host_key.pub \
  --tsa-worker-private-key keys/worker_key
