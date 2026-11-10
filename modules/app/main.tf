# Application tier (optional; the root module creates it only when
# enable_app_service = true).
#
# Free tier (F1) notes:
# - $0, but shared compute with a daily CPU quota (60 CPU-minutes/day) and 1 GB RAM.
# - No always_on (the app sleeps when idle), no deployment slots, no custom
#   domain TLS, no VNet integration, no autoscale.
# - Free plans are limited per subscription and region, so only dev enables it
#   by default; staging/prod would use B1 or above.
# - Move to B1 (Basic) when you need VNet integration or always_on.

resource "azurerm_service_plan" "this" {
  name                = "asp-${var.name}"
  resource_group_name = var.resource_group_name
  location            = var.location
  os_type             = "Linux"
  sku_name            = var.sku_name
  tags                = var.tags
}

resource "azurerm_linux_web_app" "this" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  service_plan_id     = azurerm_service_plan.this.id
  https_only          = true
  tags                = var.tags

  identity {
    # Lets the app read Key Vault secrets via RBAC later, with no stored creds.
    type = "SystemAssigned"
  }

  site_config {
    # F1 doesn't support always_on; it must be false there.
    always_on           = var.sku_name == "F1" ? false : true
    minimum_tls_version = "1.2"
    ftps_state          = "Disabled"

    application_stack {
      node_version = var.node_version
    }
  }
}
