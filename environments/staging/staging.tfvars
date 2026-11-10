# staging environment values. Placeholders only — no secrets belong in this file.
# Usage: terraform plan -var-file=environments/staging/staging.tfvars

environment = "staging"
location    = "eastus2"
name_prefix = "alpha"

vnet_address_space = ["10.20.0.0/16"]
subnets = {
  app               = ["10.20.1.0/24"]
  private-endpoints = ["10.20.2.0/24"]
}

# Optional App Service tier. Off here: F1 free plans are limited per subscription
# and region, so dev uses it. Turn on with app_service_sku = "B1" when needed.
enable_app_service = false
app_service_sku    = "F1"

# Purge protection is irreversible once enabled; keep it for prod only.
key_vault_purge_protection = false

tags = {
  owner = "cjshanahan1228"
}
