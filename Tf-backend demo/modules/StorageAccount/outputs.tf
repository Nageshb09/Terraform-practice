output "storage_account_name" {
    value = azurerm_storage_account.SAtfstate.name  
}

output "resource_group_name" {
    value = azurerm_resource_group.tfstateRG.name
}

output "storage_container_name" {
    value = azurerm_storage_container.tfstateblob.name 
}