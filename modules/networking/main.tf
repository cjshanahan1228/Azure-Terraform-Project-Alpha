# Network tier: one VNet per environment, subnets created from a map with for_each.
# Adding a subnet is a one-line change to var.subnets; removing one only touches
# that key (unlike count, which would shift indexes and recreate others).

resource "azurerm_virtual_network" "this" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  address_space       = var.address_space
  tags                = var.tags
}

resource "azurerm_subnet" "this" {
  for_each = var.subnets

  name                 = "snet-${each.key}"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = each.value
}

# TODO (later): NSGs per subnet, service endpoints / private endpoints for
# storage and Key Vault, App Service VNet integration (needs Basic tier or above).
