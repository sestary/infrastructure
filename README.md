# SeStary - Infrastructure

This repo contains all of the Infrastructure as Code pieces to build out my home Kubernetes cluster. It is running on three Ubuntu 22.04 with MicroK8s nodes.

## Pieces:

- Images: custom container images that are built.
- Manifests: all the components managed by ArgoCD.
- Terraform: deploys the initial ArgoCD piece and configures a few components.


# Usage:

## Encrypting Secrets:

Install Sops/Age and create a key, mine is stored in: `~/Library/Application\ Support/sops/age/key.txt`

```bash
sops --encrypt --age $(age-keygen -y ~/Library/Application\ Support/sops/age/key.txt) secrets.yaml > secrets.enc.yaml
```
