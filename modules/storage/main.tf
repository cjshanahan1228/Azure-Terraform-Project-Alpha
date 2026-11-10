# Presentation tier: a StorageV2 account serving a static website from the
# special $web container.
#
# CDN / Front Door notes (deferred, because it costs money):
# - Azure CDN "classic" (Microsoft/Verizon/Akamai) SKUs are retired. The
#   current option is Azure Front Door Standard, via azurerm_cdn_frontdoor_profile,
#   azurerm_cdn_frontdoor_endpoint, azurerm_cdn_frontdoor_origin_group,
#   azurerm_cdn_frontdoor_origin (host = the primary_web_host output) and
#   azurerm_cdn_frontdoor_route.
# - Front Door adds HTTPS on a custom domain, caching at the edge and a WAF
#   (Premium). Add it as a separate module once the site works directly.

resource "azurerm_storage_account" "this" {
  name                     = var.name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_kind             = "StorageV2"
  account_tier             = "Standard"
  account_replication_type = var.replication_type
  min_tls_version          = "TLS1_2"

  # The static website endpoint is served separately from blob access, so
  # anonymous blob access can stay off.
  allow_nested_items_to_be_public = false
  https_traffic_only_enabled      = true

  tags = var.tags
}

resource "azurerm_storage_account_static_website" "this" {
  storage_account_id = azurerm_storage_account.this.id
  index_document     = var.index_document
  error_404_document = var.error_404_document
}
