output "vnet_id" {
  description = "ID of the virtual network"
  value       = azurerm_virtual_network.vnet.id
}

output "vnet_name" {
  description = "Name of the virtual network"
  value       = azurerm_virtual_network.vnet.name
}

output "vnet_address_space" {
  description = "Address space of the virtual network"
  value       = azurerm_virtual_network.vnet.address_space
}

output "vnet_location" {
  description = "Location of the virtual network"
  value       = azurerm_virtual_network.vnet.location
}

output "vnet_guid" {
  description = "GUID of the virtual network"
  value       = azurerm_virtual_network.vnet.guid
}

output "nsg_id" {
  description = "Id of the NSG attached to the VNET"
  value       = azurerm_network_security_group.nsg.id
}