variable "name" {
  description = "Base name; the plan is named asp-<name> and the web app <name>."
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

variable "sku_name" {
  description = "App Service Plan SKU. F1 = free tier (see main.tf for its limits)."
  type        = string
  default     = "F1"
}

variable "node_version" {
  description = "Node.js runtime version for the placeholder app stack."
  type        = string
  default     = "20-lts"
}

variable "tags" {
  description = "Tags applied to the plan and web app."
  type        = map(string)
  default     = {}
}
