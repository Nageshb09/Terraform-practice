
resource "azurerm_resource_group" "tfstateRG" {
    name = var.resource_group_name
    location = var.resource_group_location
}

data "azurerm_client_config" "current" {
  
}

resource "azurerm_key_vault" "kv" {
    name = var.keyvault_name
    resource_group_name = azurerm_resource_group.tfstateRG.name
    location = azurerm_resource_group.tfstateRG.location
    sku_name = var.sku_name
    tenant_id = data.azurerm_client_config.current.tenant_id
    soft_delete_retention_days = 7

    access_policy {
        tenant_id = data.azurerm_client_config.current.tenant_id
        object_id = data.azurerm_client_config.current.object_id
        /*storage_permissions = [ 
            "Get", "List" , "Delete", "Set" 
        ]  
        secret_permissions = [
            "Get", "List" , "Delete", "Set"
        ] 
        key_permissions = [
            "Get", "List" , "Delete"
         ]*/
        
        storage_permissions = var.storage_permissions
        secret_permissions = var.secret_permissions
        key_permissions = var.key_permissions
    }
}  

resource "azurerm_key_vault_secret" "access_key" {
    name = var.keyvault_secret_name
    value = var.keyvault_secret_name
    key_vault_id = azurerm_key_vault.kv.id
}