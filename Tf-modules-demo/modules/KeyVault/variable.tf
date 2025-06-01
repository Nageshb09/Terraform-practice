variable "keyvault_name" {
    description = "provide keyvault name"
    type = string
}

variable "resource_group_name" {
    description = "provide RG Name"
    type = string
}

variable "resource_group_location" {
    description = "provide location"
    type = string
}

variable "sku_name" {
    description = "provide sku"
    type = string
}

variable "storage_permissions" {
    description = "provide storage permissions"
    type = list(string)
}

variable "secret_permissions" {
    description = "provide secret permissions"
    type = list(string)
}

variable "key_permissions" {
    description = "provide key permissions"
    type = list(string)
}

variable "keyvault_secret_name" {
    description = "provide secret name"
    type = string
}

variable "keyvault_secret_value" {
    description = "provide value"
    type = string
}