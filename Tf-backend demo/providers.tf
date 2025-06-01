terraform {
    required_providers {
        azurerm = {
            source = "hashicorp/azurerm"
            version = "~> 3.0"
        }
    }

    /*backend "azurerm" {
            storage_account_name = "tfstatevrfxgr" 
            resource_group_name = "tfstateRG"
            container_name = "tfstate"
            key = "terraform.tfstate"
    }*/
}

provider "azurerm" {
    features {}
  
}