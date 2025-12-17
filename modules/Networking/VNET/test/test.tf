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
  name     = "rg-vnet-example"
  location = local.location

  tags = local.tags
}

# Example 1: Minimal VNET with defaults
module "vnet_minimal" {
  source = "../../VNET"

  name                = "vnet-minimal"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location

  tags = local.tags
}

# Example 2: VNET with custom address space and DNS
module "vnet_custom" {
  source = "../../VNET"

  name                = "vnet-custom"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  address_space       = ["10.1.0.0/16", "10.2.0.0/16"]
  dns_servers         = ["10.1.0.4", "10.1.0.5"]

  tags = local.tags
}

# Outputs
output "minimal_vnet_id" {
  value = module.vnet_minimal.vnet_id
}

output "minimal_vnet_address_space" {
  value = module.vnet_minimal.vnet_address_space
}

output "custom_vnet_id" {
  value = module.vnet_custom.vnet_id
}

output "custom_vnet_guid" {
  value = module.vnet_custom.vnet_guid
}