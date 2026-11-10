variable "name" {
  description = "VNet name."
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

variable "address_space" {
  description = "VNet address space."
  type        = list(string)
}

variable "subnets" {
  description = "Subnets keyed by name; each value is a list of CIDR prefixes."
  type        = map(list(string))
}

variable "tags" {
  description = "Tags applied to the VNet."
  type        = map(string)
  default     = {}
}
