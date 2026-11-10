variable "name" {
  description = "Key Vault name (3-24 chars, globally unique)."
  type        = string
}

variable "resource_group_name" {
  description = "Resource group to deploy into."
  type        = string
}

variable "location" {
  description = "Azure region."
  type        = string
}

variable "tenant_id" {
  description = "Entra ID tenant that owns the vault."
  type        = string
}

variable "sku_name" {
  description = "Key Vault SKU: standard or premium (HSM-backed keys)."
  type        = string
  default     = "standard"
}

variable "soft_delete_retention_days" {
  description = "Days a deleted vault/secret is recoverable (7-90)."
  type        = number
  default     = 7
}

variable "purge_protection_enabled" {
  description = "Block permanent deletion during the retention window. Irreversible once on."
  type        = bool
  default     = false
}

variable "tags" {
  description = "Tags applied to the vault."
  type        = map(string)
  default     = {}
}
