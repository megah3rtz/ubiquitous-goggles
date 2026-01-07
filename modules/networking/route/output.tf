output "route_table_id" {
  description = "ID of the route table"
  value       = azurerm_route_table.main.id
}

output "route_table_name" {
  description = "Name of the route table"
  value       = azurerm_route_table.main.name
}

output "route_ids" {
  description = "Map of route names to their IDs"
  value       = { for k, v in azurerm_route.routes : k => v.id }
}