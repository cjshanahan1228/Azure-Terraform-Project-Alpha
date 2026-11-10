# Secrets: one Key Vault per environment using Azure RBAC for data-plane access
# (no access policies). Grant roles such as "Key Vault Secrets User" to
# identities, e.g. the App Service's managed identity:
#
#   resource "azurerm_role_assignment" "app_secrets_user" {
#     scope                = azurerm_key_vault.this.id
#     role_definition_name = "Key Vault Secrets User"
#     principal_id         = <module.app[0].principal_id>
#   }
#
# Whoever runs Terraform needs "Key Vault Secrets Officer" (or Administrator)
# to manage secrets in the vault; RBAC changes can take a few minutes to apply.

resource "azurerm_key_vault" "this" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  tenant_id           = var.tenant_id
  sku_name            = var.sku_name

  rbac_authorization_enabled = true
  soft_delete_retention_days = var.soft_delete_retention_days
  purge_protection_enabled   = var.purge_protection_enabled

  tags = var.tags
}
