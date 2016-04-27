#!/bin/bash

set -eux

postgres_source=$(echo $VCAP_SERVICES | jq '.elephantsql [0] .credentials .uri' | tr -d '"')

rm -rf testing
mkdir testing

pushd testing
  curl -L https://github.com/concourse/concourse/releases/download/v1.1.0/concourse_linux_amd64 -o concourse
  chmod +x concourse

  ssh-keygen -t rsa -f host_key -N ''
  ssh-keygen -t rsa -f worker_key -N ''
  ssh-keygen -t rsa -f session_signing_key -N ''

  cp worker_key.pub authorized_worker_keys

  netstat -tulpn | grep :2222
  ./concourse web \
    -d \
    --session-signing-key session_signing_key \
    --tsa-host-key host_key \
    --tsa-authorized-keys authorized_worker_keys \
    --external-url localhost:8080 \
    --postgres-data-source $postgres_source \
    --tsa-bind-port=7777
popd
