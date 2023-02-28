#!/bin/bash

# This is set to ensure that if helm fails the whole script fails and shows a proper exit code in Argo
set -o pipefail

kustomize build --enable-helm . | argocd-vault-plugin generate -"
