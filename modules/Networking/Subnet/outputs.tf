output "subnet_id" {
  description = "ID of the subnet"
  value       = azurerm_subnet.subnet.id
}

output "subnet_name" {
  description = "Name of the subnet"
  value       = azurerm_subnet.subnet.name
}

output "subnet_address_prefixes" {
  description = "Address prefixes of the subnet"
  value       = azurerm_subnet.subnet.address_prefixes
}