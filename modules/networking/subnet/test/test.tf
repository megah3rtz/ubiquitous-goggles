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
  name     = "rg-subnet-example"
  location = "UK West"
}

# Create VNET (required for subnet)
resource "azurerm_virtual_network" "example" {
  name                = "vnet-example"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  address_space       = ["10.0.0.0/16"]
}

# Example 1: Minimal subnet
module "subnet_minimal" {
  source = "../../subnet" # Update path to your module location

  name                 = "subnet-minimal"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.0.1.0/24"]
}

# Example 2: Subnet with service endpoints
module "subnet_with_endpoints" {
  source = "../../subnet"

  name                 = "subnet-endpoints"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.0.2.0/24"]
  service_endpoints = [
    "Microsoft.Storage",
    "Microsoft.Sql",
    "Microsoft.KeyVault"
  ]
}

# Example 3: Subnet with delegation (e.g., for Azure Container Instances)
module "subnet_delegated" {
  source = "../../subnet"

  name                 = "subnet-aci"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.0.3.0/24"]

  delegations = [{
    name = "aci-delegation"
    service_delegation = {
      name = "Microsoft.ContainerInstance/containerGroups"
      actions = [
        "Microsoft.Network/virtualNetworks/subnets/action"
      ]
    }
  }]
}

# Example 4: Subnet for private endpoints
module "subnet_private_endpoints" {
  source = "../../subnet"

  name                                      = "subnet-private-endpoints"
  resource_group_name                       = azurerm_resource_group.example.name
  virtual_network_name                      = azurerm_virtual_network.example.name
  address_prefixes                          = ["10.0.4.0/24"]
  private_endpoint_network_policies_enabled = false
}

# Outputs
output "minimal_subnet_id" {
  value = module.subnet_minimal.subnet_id
}

output "endpoints_subnet_id" {
  value = module.subnet_with_endpoints.subnet_id
}

output "delegated_subnet_id" {
  value = module.subnet_delegated.subnet_id
}

output "private_endpoints_subnet_id" {
  value = module.subnet_private_endpoints.subnet_id
}