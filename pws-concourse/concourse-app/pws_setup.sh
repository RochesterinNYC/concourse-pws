#!/bin/bash

set -eux

postgres_source=$(echo $VCAP_SERVICES | jq '.elephantsql [0] .credentials .uri' | tr -d '"')

curl -L https://github.com/concourse/concourse/releases/download/v1.1.0/concourse_linux_amd64 -o concourse
chmod +x concourse

./concourse web \
  -d \
  --session-signing-key keys/session_signing_key \
  --tsa-host-key keys/host_key \
  --tsa-authorized-keys keys/authorized_worker_keys \
  --external-url localhost:8080 \
  --postgres-data-source $postgres_source \
  --tsa-bind-port=7777
