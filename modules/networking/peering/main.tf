resource "azurerm_virtual_network_peering" "source_to_destination" {
  name                         = "${var.source_vnet_name}-to-${var.destination_vnet_name}"
  resource_group_name          = var.source_resource_group_name
  virtual_network_name         = var.source_vnet_name
  remote_virtual_network_id    = var.destination_vnet_id
  allow_virtual_network_access = var.allow_virtual_network_access
  allow_forwarded_traffic      = var.allow_forwarded_traffic
  allow_gateway_transit        = var.allow_gateway_transit
  use_remote_gateways          = var.use_remote_gateways
}

# Peering from destination to source
resource "azurerm_virtual_network_peering" "destination_to_source" {
  name                         = "${var.destination_vnet_name}-to-${var.source_vnet_name}"
  resource_group_name          = var.destination_resource_group_name
  virtual_network_name         = var.destination_vnet_name
  remote_virtual_network_id    = var.source_vnet_id
  allow_virtual_network_access = var.allow_virtual_network_access
  allow_forwarded_traffic      = var.allow_forwarded_traffic
  allow_gateway_transit        = var.use_remote_gateways
  use_remote_gateways          = var.allow_gateway_transit
}