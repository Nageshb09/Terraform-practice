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

module "StorageAccount" {
    source = "./modules/StorageAccount"
    resource_group_name = "storageaccountRG"
    resource_group_location = "eastus"
    storage_account_name = "storagdemoe"
    storage_container_name = "containerrreeew"
  
}*/

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