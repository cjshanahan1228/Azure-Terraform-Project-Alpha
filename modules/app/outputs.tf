output "service_plan_id" {
  description = "App Service Plan ID."
  value       = azurerm_service_plan.this.id
}

output "web_app_id" {
  description = "Linux Web App ID."
  value       = azurerm_linux_web_app.this.id
}

output "default_hostname" {
  description = "Default *.azurewebsites.net hostname."
  value       = azurerm_linux_web_app.this.default_hostname
}

output "principal_id" {
  description = "Object ID of the web app's system-assigned identity (for Key Vault RBAC)."
  value       = azurerm_linux_web_app.this.identity[0].principal_id
}
