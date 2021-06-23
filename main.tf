terraform {
    required_providers {
        azurerm = {
            source  = "hashicorp/azurerm"
            version = "~> 2.46.0"
        }
    }
}

provider "azurerm" {
    features {}
}

resource "azurerm_resource_group" "main" {
    name     = "${var.project_name}-rg"
    location = var.location
}

resource "azurerm_public_ip" "main" {
    name                = "${var.project_name}-IP"
    location            = var.location
    resource_group_name = azurerm_resource_group.main.name
    allocation_method   = "Static"
}

resource "azurerm_lb" "main" {
    name                = var.project_name
    location            = var.location
    resource_group_name = azurerm_resource_group.main.name

    frontend_ip_configuration {
        name                 = "PublicIPAddress"
        public_ip_address_id = azurerm_public_ip.main.id
    }
}
