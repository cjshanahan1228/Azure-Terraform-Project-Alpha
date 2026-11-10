output "storage_account_id" {
  description = "Storage account ID."
  value       = azurerm_storage_account.this.id
}

output "storage_account_name" {
  description = "Storage account name."
  value       = azurerm_storage_account.this.name
}

output "primary_web_endpoint" {
  description = "Static website URL, e.g. https://<account>.z13.web.core.windows.net/."
  value       = azurerm_storage_account.this.primary_web_endpoint
}

output "primary_web_host" {
  description = "Static website hostname (use as a Front Door origin host)."
  value       = azurerm_storage_account.this.primary_web_host
}
