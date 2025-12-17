output "nsg_id" {
  description = "ID of the network security group"
  value       = azurerm_network_security_group.nsg.id
}

output "nsg_name" {
  description = "Name of the network security group"
  value       = azurerm_network_security_group.nsg.name
}

output "nsg_location" {
  description = "Location of the network security group"
  value       = azurerm_network_security_group.nsg.location
}

output "security_rule_ids" {
  description = "Map of security rule names to IDs"
  value       = { for k, v in azurerm_network_security_rule.rules : k => v.id }
}