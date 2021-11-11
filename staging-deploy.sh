#!/bin/bash
set -x
PR_NUMBER=$1
echo $PR_NUMBER
export FULL_PR_NUMBER="pr-$PR_NUMBER"
sudo snap install yq
yq eval -i '.app.versions += [env(FULL_PR_NUMBER)'] superhero-ui/values-staging.yaml
yq eval -i '.app.ingress.hosts += [{"host": "'${FULL_PR_NUMBER}'.stg.aepps.com", "paths": { "path": "/"}}]' superhero-ui/values-staging.yaml
yq eval -i '.. style="double"' superhero-ui/values-staging.yaml
cat superhero-ui/values-staging.yaml
