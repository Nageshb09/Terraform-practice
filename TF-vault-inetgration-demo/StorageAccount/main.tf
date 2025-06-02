/*resource "random_string" "res_code" {
    length = 6
    special = false
    upper = false
}
*/
resource "azurerm_resource_group" "tfstateRG" {
    name = var.rgname
    location = var.resource_group_location
}


resource "azurerm_storage_account" "SAtfstate" {
    name = var.storage_account_name
    resource_group_name = azurerm_resource_group.tfstateRG.name
    location = azurerm_resource_group.tfstateRG.location
    account_tier = var.account_tier
    account_replication_type = var.account_replication_type
    allow_nested_items_to_be_public = false

    tags = {
        environment = "staging"
    }
}
resource "azurerm_storage_container" "tfstateblob" {
    name = var.storage_container_name
    container_access_type = var.container_access_type
    storage_account_name = azurerm_storage_account.SAtfstate.name
}