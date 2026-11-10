output "resource_group_name" {
  description = "Name of the environment resource group."
  value       = azurerm_resource_group.this.name
}

output "vnet_id" {
  description = "ID of the environment VNet."
  value       = module.networking.vnet_id
}

output "subnet_ids" {
  description = "Map of subnet name to subnet ID."
  value       = module.networking.subnet_ids
}

output "static_website_url" {
  description = "Primary endpoint of the blob static website."
  value       = module.storage.primary_web_endpoint
}

output "app_service_hostname" {
  description = "Default hostname of the web app, or null when enable_app_service is false."
  value       = one(module.app[*].default_hostname)
}

output "key_vault_uri" {
  description = "URI of the environment Key Vault."
  value       = module.secrets.vault_uri
}
