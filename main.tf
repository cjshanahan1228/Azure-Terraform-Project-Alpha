# Root module: wires the four tiers together. Scaffolding only; nothing here has
# been applied. Run `terraform plan` per environment (see README.md).

locals {
  # e.g. "alpha-dev"; storage/Key Vault names derive from this (no hyphens there).
  base_name = "${var.name_prefix}-${var.environment}"

  tags = merge(
    {
      project     = "azure-terraform-project-alpha"
      environment = var.environment
      managed_by  = "terraform"
    },
    var.tags,
  )
}

data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "this" {
  name     = "rg-${local.base_name}"
  location = var.location
  tags     = local.tags
}

# Tier 1: network
module "networking" {
  source = "./modules/networking"

  name                = "vnet-${local.base_name}"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  address_space       = var.vnet_address_space
  subnets             = var.subnets
  tags                = local.tags
}

# Tier 2: presentation (blob static website; CDN / Front Door later)
module "storage" {
  source = "./modules/storage"

  # Storage account names: 3-24 chars, lowercase letters and digits only.
  name                = substr("st${var.name_prefix}${var.environment}web", 0, 24)
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  tags                = local.tags
}

# Tier 3: application (optional; toggled per environment)
module "app" {
  source = "./modules/app"
  count  = var.enable_app_service ? 1 : 0

  name                = "app-${local.base_name}"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  sku_name            = var.app_service_sku
  tags                = local.tags
}

# Cross-cutting: secrets
module "secrets" {
  source = "./modules/secrets"

  # Key Vault names: 3-24 chars, globally unique.
  name                     = substr("kv-${local.base_name}", 0, 24)
  resource_group_name      = azurerm_resource_group.this.name
  location                 = azurerm_resource_group.this.location
  tenant_id                = data.azurerm_client_config.current.tenant_id
  purge_protection_enabled = var.key_vault_purge_protection
  tags                     = local.tags
}
