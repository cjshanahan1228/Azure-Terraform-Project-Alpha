terraform {
  required_version = ">= 1.5.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 5.13"
    }
  }

  # Partial configuration: the real values live in environments/<env>/backend.hcl
  # and are supplied at init time, so each environment keeps its own state:
  #   terraform init -backend-config=environments/dev/backend.hcl
  backend "azurerm" {}
}

provider "azurerm" {
  features {}

  # Auth comes from the ARM_* environment variables (CI) or `az login` (local).
  # Use Entra ID for storage data-plane calls instead of shared keys.
  storage_use_azuread = true
}
