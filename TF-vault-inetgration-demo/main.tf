/*
module "VM" {
    source = "./modules/VM"
    rgname = "NaveenRG"
    rglocation = "East US"
    vnetname = "NaveenVnet"
    vnetaddrspace = [ "10.0.0.0/16" ]
    subnetname = "NaveenSubnet"
    subnetprefixes = [ "10.0.2.0/24" ]
    netinterfacename = "NaveenNic"
    ipallocation = "Dynamic"
    ipconfigname = "config"
    vmname = "NaveenVM"
    vmsize = "Standard_F2"
    computer_name = "Naveen"
    admin_username = "Naveen"
    admin_password = "N@veen123"
    os_disk = {
        name = "NaveenOSDisk"
        storage_account_type = "Standard_LRS"
        caching = "ReadWrite"
    }
    source_image_reference = {
        publisher = "Canonical"
        offer     = "0001-com-ubuntu-server-jammy"
        sku       = "22_04-lts"
        version   = "latest"
    }
    publicIpName = "NaveenPublicIp"
    publicIp_allocation_method = "Dynamic"
}

provider "vault" {
  address = "172.206.192.57:8200"
  skip_child_token = true

  auth_login {
    path = "auth/approle/login"

    parameters = {
      role_id = "878b04af-b8c3-b286-1d7d-bfab7e8bc673"
      secret_id = "3ade1674-9883-e47d-ca3d-0a7c240d623f"
    }
  }
}

data "vault_kv_secret_v2" "name" {
  mount = "secret"
  name = "test-secret"
}

module "StorageAccount" {
    source = "./modules/StorageAccount"
    resource_group_name = "storageaccountRG"
    resource_group_location = "eastus"
    storage_account_name = "storagdemoe"
    storage_container_name = "containerrreeew"
  
}
module "KeyVault" {
    source = "./modules/KeyVault"
    keyvault_name = "demokeyvault1122332321"
    resource_group_name = "keyvaultrg"  
    resource_group_location = "eastus"
    sku_name = "standard"
    storage_permissions = [ "Get", "List" , "Delete", "Set" ]
    key_permissions = [ "Get", "List" , "Delete" ]
    secret_permissions = [ "Get", "List" , "Delete", "Set" ]
    keyvault_secret_name = "secretkeyvalue"
    keyvault_secret_value = "abcdefghi"
}
*/
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


provider "vault" {
  address = "http://172.206.192.57:8200"
  skip_child_token = true

  auth_login {
    path = "auth/approle/login"

    parameters = {
      role_id = "878b04af-b8c3-b286-1d7d-bfab7e8bc673"
      secret_id = "26e608f3-501c-b241-c936-6c7f21135159"
    }
  }
}

data "vault_kv_secret_v2" "name" {
  mount = "kv"
  name = "test-secret"
}

resource "azurerm_resource_group" "rg" {
    name = "abcdfg"
    location = "eastus"
  
}
resource "azurerm_storage_account" "name" {
    resource_group_name = azurerm_resource_group.rg.name 
    name = "mystorageacouttnguib"
    location = azurerm_resource_group.rg.location
    account_tier = "Standard"
    account_replication_type = "LRS"
    tags = {
      name = "test"
      secret = data.vault_kv_secret_v2.name.data["username"]
    }
}