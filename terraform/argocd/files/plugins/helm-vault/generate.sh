#!/bin/sh

ARGUMENTS=$(echo "$ARGOCD_APP_PARAMETERS" | jq -r '.[] | select(.name == "values-files").array | .[] | "--values=" + .')
PARAMETERS=$(echo "$ARGOCD_APP_PARAMETERS" | jq -r '.[] | select(.name == "helm-parameters").map | to_entries | map("\(.key)=\(.value)") | .[] | "--set=" + .')

echo "$ARGOCD_APP_NAME . --namespace $ARGOCD_APP_NAMESPACE $ARGUMENTS $PARAMETERS" | xargs helm template | argocd-vault-plugin generate -
