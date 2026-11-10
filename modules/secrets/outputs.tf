output "vault_id" {
  description = "Key Vault ID (scope for role assignments)."
  value       = azurerm_key_vault.this.id
}

output "vault_name" {
  description = "Key Vault name."
  value       = azurerm_key_vault.this.name
}

output "vault_uri" {
  description = "Key Vault URI, e.g. https://<name>.vault.azure.net/."
  value       = azurerm_key_vault.this.vault_uri
}
