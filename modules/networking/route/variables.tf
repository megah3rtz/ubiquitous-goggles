variable "route_table_name" {
  description = "Name of the route table"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure region for the route table"
  type        = string
}

variable "disable_bgp_route_propagation" {
  description = "Disable BGP route propagation on the route table"
  type        = bool
  default     = false
}

variable "routes" {
  description = "List of routes to create"
  type = list(object({
    name                   = string
    address_prefix         = string
    next_hop_type          = string
    next_hop_in_ip_address = optional(string)
  }))
  default = []
}

variable "subnet_ids" {
  description = "List of subnet IDs to associate with this route table"
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "Tags to apply to the route table"
  type        = map(string)
  default     = {}
}