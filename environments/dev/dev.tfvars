# dev environment values. Placeholders only — no secrets belong in this file.
# Usage: terraform plan -var-file=environments/dev/dev.tfvars

environment = "dev"
location    = "eastus2"
name_prefix = "alpha"

vnet_address_space = ["10.10.0.0/16"]
subnets = {
  app               = ["10.10.1.0/24"]
  private-endpoints = ["10.10.2.0/24"]
}

# Optional App Service tier (F1 free tier by default).
enable_app_service = true
app_service_sku    = "F1"

# Purge protection is irreversible once enabled; keep it for prod only.
key_vault_purge_protection = false

tags = {
  owner = "cjshanahan1228"
}
