# prod environment values. Placeholders only — no secrets belong in this file.
# Usage: terraform plan -var-file=environments/prod/prod.tfvars

environment = "prod"
location    = "eastus2"
name_prefix = "alpha"

vnet_address_space = ["10.30.0.0/16"]
subnets = {
  app               = ["10.30.1.0/24"]
  private-endpoints = ["10.30.2.0/24"]
}

# Optional App Service tier. Off here: F1 free plans are limited per subscription
# and region, so dev uses it. Turn on with app_service_sku = "B1" when needed.
enable_app_service = false
app_service_sku    = "F1"

# Purge protection is irreversible once enabled; keep it for prod only.
key_vault_purge_protection = true

tags = {
  owner = "cjshanahan1228"
}
