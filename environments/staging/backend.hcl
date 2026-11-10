# Remote state backend for the staging environment (partial configuration for the
# empty backend "azurerm" {} block in versions.tf).
# Usage: terraform init -backend-config=environments/staging/backend.hcl
#
# PLACEHOLDERS: replace every REPLACE_ME value with the real state storage
# before running init. Each environment uses its OWN storage account so a
# mistake in one environment's state can't touch another's.

resource_group_name  = "REPLACE_ME-rg-tfstate-staging"
storage_account_name = "REPLACEMEsttfstatestaging" # 3-24 lowercase letters/digits
container_name       = "tfstate"
key                  = "alpha-staging.tfstate"

# Authenticate to the state blob with Entra ID (RBAC: Storage Blob Data
# Contributor) instead of storage account keys.
use_azuread_auth = true
