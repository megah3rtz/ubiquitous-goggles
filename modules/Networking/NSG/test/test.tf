# Configure the Azure Provider
terraform {
  required_version = ">= 1.14.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.56.0"
    }
  }
}
provider "azurerm" {
  features {}
}

locals {
  tags = {
    Environmenmt = "Test"
    DeployedWith = "Terraform"
  }
  location = "UK South"
}


# Create Resource Group
resource "azurerm_resource_group" "example" {
  name     = "rg-nsg-example"
  location = "UK West"
}

# Example 1: Minimal NSG (no rules)
module "nsg_minimal" {
  source = "../../nsg" # Update path to your module location

  name                = "nsg-minimal"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location

  tags = local.tags
}

# Example 2: NSG with common web application rules
module "nsg_web" {
  source = "../../nsg"

  name                = "nsg-web"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location

  security_rules = [
    {
      name                       = "AllowHTTPS"
      priority                   = 100
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "443"
      source_address_prefix      = "Internet"
      destination_address_prefix = "*"
      description                = "Allow HTTPS traffic from Internet"
    },
    {
      name                       = "AllowHTTP"
      priority                   = 110
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "80"
      source_address_prefix      = "Internet"
      destination_address_prefix = "*"
      description                = "Allow HTTP traffic from Internet"
    },
    {
      name                       = "DenyAllInbound"
      priority                   = 4096
      direction                  = "Inbound"
      access                     = "Deny"
      protocol                   = "*"
      source_port_range          = "*"
      destination_port_range     = "*"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
      description                = "Deny all other inbound traffic"
    }
  ]

  tags = local.tags
}

# Example 3: NSG with multiple port ranges and address prefixes
module "nsg_database" {
  source = "../../nsg"

  name                = "nsg-database"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location

  security_rules = [
    {
      name                       = "AllowAppTierSQL"
      priority                   = 100
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_ranges    = ["1433", "3306", "5432"]
      source_address_prefixes    = ["10.0.1.0/24", "10.0.2.0/24"]
      destination_address_prefix = "*"
      description                = "Allow database access from app tier"
    },
    {
      name                       = "DenyAllInbound"
      priority                   = 4096
      direction                  = "Inbound"
      access                     = "Deny"
      protocol                   = "*"
      source_port_range          = "*"
      destination_port_range     = "*"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
      description                = "Deny all other inbound traffic"
    }
  ]

  tags = local.tags
}

# Example 4: Associate NSG with subnet
resource "azurerm_virtual_network" "example" {
  name                = "vnet-example"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "example" {
  name                 = "subnet-example"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_subnet_network_security_group_association" "example" {
  subnet_id                 = azurerm_subnet.example.id
  network_security_group_id = module.nsg_web.nsg_id
}

# Outputs
output "minimal_nsg_id" {
  value = module.nsg_minimal.nsg_id
}

output "web_nsg_id" {
  value = module.nsg_web.nsg_id
}

output "web_nsg_rules" {
  value = module.nsg_web.security_rule_ids
}

output "database_nsg_id" {
  value = module.nsg_database.nsg_id
}