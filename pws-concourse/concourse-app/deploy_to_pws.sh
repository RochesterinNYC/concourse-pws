#!/bin/bash

set -eux

cf delete-service concourse-pg -f
cf create-service elephantsql turtle concourse-pg

mkdir -p keys
pushd keys
  ssh-keygen -t rsa -f host_key -N ''
  ssh-keygen -t rsa -f worker_key -N ''
  ssh-keygen -t rsa -f session_signing_key -N ''
  cp worker_key.pub authorized_worker_keys
popd

cf push -f manifest.yml
