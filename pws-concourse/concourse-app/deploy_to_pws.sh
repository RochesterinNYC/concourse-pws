#!/bin/bash

set -eux

cf delete-service concourse-pg -f
cf create-service elephantsql turtle concourse-pg

cf push -f manifest.yml
