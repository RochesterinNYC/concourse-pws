# Deploy Concourse to PWS

Can it be done?! I don't know, let's see!

Answer is __NO__, it can't right now. The web instance can successfully be deployed to PWS or a CF deployment. However, worker instances have to be run with `sudo` (https://concourse.ci/binaries.html) due to container orchestration. Currently, apps in a CF deployment do not have sudo access during staging or runtime.

Longshot: If Concourse could use the Cloud Controller V3 Tasks API instead of using containers for jobs, might be possible?

### Deploying to PWS

```
cd pws-concourse/concourse-app
./deploy_to_pws.sh
```
