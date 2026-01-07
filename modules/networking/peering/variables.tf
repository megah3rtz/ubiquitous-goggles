variable "source_vnet_name" {
  description = "Name of the source virtual network"
  type        = string
}

variable "source_vnet_id" {
  description = "ID of the source virtual network"
  type        = string
}

variable "source_resource_group_name" {
  description = "Resource group name of the source virtual network"
  type        = string
}

variable "destination_vnet_name" {
  description = "Name of the destination virtual network"
  type        = string
}

variable "destination_vnet_id" {
  description = "ID of the destination virtual network"
  type        = string
}

variable "destination_resource_group_name" {
  description = "Resource group name of the destination virtual network"
  type        = string
}

variable "allow_virtual_network_access" {
  description = "Allow access from the remote virtual network"
  type        = bool
  default     = true
}

variable "allow_forwarded_traffic" {
  description = "Allow forwarded traffic from the remote virtual network"
  type        = bool
  default     = false
}

variable "allow_gateway_transit" {
  description = "Allow gateway transit for the remote virtual network"
  type        = bool
  default     = false
}

variable "use_remote_gateways" {
  description = "Use remote gateways for the peering"
  type        = bool
  default     = false
}