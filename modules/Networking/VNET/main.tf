resource "azurerm_virtual_network" "vnet" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = var.address_space
  dns_servers         = length(var.dns_servers) > 0 ? var.dns_servers : null

  dynamic "ddos_protection_plan" {
    for_each = var.enable_ddos_protection && var.ddos_protection_plan_id != null ? [1] : []
    content {
      id     = var.ddos_protection_plan_id
      enable = true
    }
  }

  tags = var.tags
}

resource "azurerm_network_security_group" "nsg" {
  name                = "${var.name}-nsg"
  location            = var.location
  resource_group_name = var.resource_group_name

  tags = var.tags
}

resource "azurerm_network_security_rule" "blockin" {

  name                                       = "${var.name}-blockin"
  priority                                   = 4096
  direction                                  = "Inbound"
  access                                     = "Deny"
  protocol                                   = "*"
  source_port_range                          = "*"
  destination_port_range                     = "*"
  source_address_prefix                      = "*"
  destination_address_prefix                 = "*"
  description                                = "Default VNET block inbound traffic"
  resource_group_name                        = var.resource_group_name
  network_security_group_name                = azurerm_network_security_group.nsg.name
}

resource "azurerm_network_security_rule" "blockout" {

  name                                       = "${var.name}-blockout"
  priority                                   = 4096
  direction                                  = "Outbound"
  access                                     = "Deny"
  protocol                                   = "*"
  source_port_range                          = "*"
  destination_port_range                     = "*"
  source_address_prefix                      = "*"
  destination_address_prefix                 = "*"
  description                                = "Default VNET block outbound traffic"
  resource_group_name                        = var.resource_group_name
  network_security_group_name                = azurerm_network_security_group.nsg.name
}