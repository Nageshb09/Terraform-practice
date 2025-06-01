variable "resource_group_name" {
    description = "provide RG Name"
    type = string
}

variable "resource_group_location" {
    description = "provide location"
    type = string
}

variable "storage_account_name" {
    description = "provide SA name"
    type = string
}

variable "account_tier" {
    description = "provide access tier"
    type = string
    default = "Standard"
}

variable "account_replication_type" {
    description = "provide repliaction type"
    type = string
    default = "LRS"
}

variable "storage_container_name" {
    description = "provide container name"
    type = string
}

variable "container_access_type" {
    description = "provide container type"
    type = string
    default = "private"
}