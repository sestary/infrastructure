#!/bin/bash

# This is set to ensure that if helm fails the whole script fails and shows a proper exit code in Argo
set -o pipefail

ARGUMENTS=$(echo "$ARGOCD_APP_PARAMETERS" | jq -r '.[] | select(.name == "values-files").array | .[] | "--values=" + .')
PARAMETERS=$(echo "$ARGOCD_APP_PARAMETERS" | jq -r '.[] | select(.name == "helm-parameters").map | to_entries | map("\(.key)=\(.value)") | .[] | "--set=" + .')

echo "$ARGOCD_APP_NAME . --namespace $ARGOCD_APP_NAMESPACE $ARGUMENTS $PARAMETERS" | xargs helm template | argocd-vault-plugin generate -
