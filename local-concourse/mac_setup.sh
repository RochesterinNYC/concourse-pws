#!/bin/bash

set -eo

brew install postgres
brew services start postgresql
createdb atc || true

rm -rf testing
mkdir testing

pushd testing
  curl -L https://github.com/concourse/concourse/releases/download/v1.1.0/concourse_darwin_amd64 -o concourse
  chmod +x concourse

  ssh-keygen -t rsa -f host_key -N ''
  ssh-keygen -t rsa -f worker_key -N ''
  ssh-keygen -t rsa -f session_signing_key -N ''

  cp worker_key.pub authorized_worker_keys

  ./concourse web \
    -d \
    --session-signing-key session_signing_key \
    --tsa-host-key host_key \
    --tsa-authorized-keys authorized_worker_keys \
    --external-url localhost:8080
popd
