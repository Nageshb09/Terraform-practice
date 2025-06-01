terraform {
  required_providers {
    azurerm = {
        source = "hashicorp/azurerm"
        version = "~> 3.0"
    }
  }
}

provider "azurerm" {
    features {
      
    }
}

resource "azurerm_container_registry" "container_reg" {
    name = "localexecdemonaveen"
    resource_group_name = "NaveenRG"
    location = "eastus"
    sku = "Standard"
    admin_enabled = false
}

resource "null_resource" "image" {
  triggers = {
    myacr=azurerm_container_registry.container_reg.id
  }
  provisioner "local-exec" {
    command = "az acr show -n ${azurerm_container_registry.container_reg.name} --resource-group ${azurerm_container_registry.container_reg.resource_group_name}"    
  }
}
