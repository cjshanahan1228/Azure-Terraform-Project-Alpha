variable "name" {
  description = "Storage account name (3-24 lowercase letters/digits, globally unique)."
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

variable "replication_type" {
  description = "Replication: LRS for dev/staging; consider ZRS or GRS for prod."
  type        = string
  default     = "LRS"
}

variable "index_document" {
  description = "Static website index document."
  type        = string
  default     = "index.html"
}

variable "error_404_document" {
  description = "Static website 404 document."
  type        = string
  default     = "404.html"
}

variable "tags" {
  description = "Tags applied to the storage account."
  type        = map(string)
  default     = {}
}
