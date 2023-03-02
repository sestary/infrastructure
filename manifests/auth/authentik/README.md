# Authentik

This provides SSO for all the other applications.

## Initial setup

There is a few steps that need to be completed after the deployment is complete but before we can use the Terraform project to create resources.

1. Navigate to `https://sso.sestary.eu/if/flow/initial-setup/` to setup the Admin Username/Password
2. Then navigate to `https://sso.sestary.eu/if/admin/#/core/tokens` to setup a new API token
   - Identifier: `Terraform`
   - User: `akadmin`
   - Intent: `API Token`
   - Description: `Allow Terraform to manage Authentik`
   - Expiring: Unselect
