variable "environment" {
  description = "Deployment environment name. Drives naming and per-env settings."
  type        = string

  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "environment must be one of: dev, staging, prod."
  }
}

variable "location" {
  description = "Azure region for all resources."
  type        = string
  default     = "eastus2"
}

variable "name_prefix" {
  description = "Short lowercase prefix used in resource names (letters and digits, 3-10 chars)."
  type        = string
  default     = "alpha"

  validation {
    condition     = can(regex("^[a-z0-9]{3,10}$", var.name_prefix))
    error_message = "name_prefix must be 3-10 lowercase letters or digits (storage account names are strict)."
  }
}

variable "tags" {
  description = "Extra tags merged onto every resource."
  type        = map(string)
  default     = {}
}

# --- Networking -------------------------------------------------------------

variable "vnet_address_space" {
  description = "Address space for the environment VNet."
  type        = list(string)
  default     = ["10.10.0.0/16"]
}

variable "subnets" {
  description = "Subnets to create, keyed by name. Each value is a list of CIDR prefixes."
  type        = map(list(string))
  default = {
    app               = ["10.10.1.0/24"]
    private-endpoints = ["10.10.2.0/24"]
  }
}

# --- App tier ---------------------------------------------------------------

variable "enable_app_service" {
  description = "Create the optional App Service tier (Service Plan + Linux Web App)."
  type        = bool
  default     = false
}

variable "app_service_sku" {
  description = "App Service Plan SKU. F1 is the free tier."
  type        = string
  default     = "F1"
}

# --- Secrets ----------------------------------------------------------------

variable "key_vault_purge_protection" {
  description = "Enable Key Vault purge protection. Leave off in dev so the vault can be recreated; turn on in prod."
  type        = bool
  default     = false
}
