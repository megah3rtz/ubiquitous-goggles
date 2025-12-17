
variable "name" {
  description = "Name of the virtual network"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure region for resources"
  type        = string
}

variable "address_space" {
  description = "Address space for the virtual network"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "dns_servers" {
  description = "List of DNS servers for the VNET"
  type        = list(string)
  default     = []
}

variable "enable_ddos_protection" {
  description = "Enable DDoS protection plan"
  type        = bool
  default     = false
}

variable "ddos_protection_plan_id" {
  description = "ID of the DDoS protection plan (required if enable_ddos_protection is true)"
  type        = string
  default     = null
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}