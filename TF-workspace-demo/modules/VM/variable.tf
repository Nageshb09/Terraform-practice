variable "rgname" {
  description = "name of RG"
  type = string
}

variable "rglocation" {
  description = "name of location"
  type = string
}

variable "vnetname" {
    description = "name of vnet"
    type = string
}

variable "vnetaddrspace" {
  type = set(string)
  description = "provide vnet ip address space"
}

variable "subnetname" {
    type = string
    description = "provide subnet value"
}

variable "subnetprefixes" {
  type = set(string)
  description = "provide subnet range details"
}

variable "netinterfacename" {
    type = string
    description = "provide azure nic name"
}

variable "ipallocation" {
    type = string
    description = "provide ip addrees allocation type"
}

variable "ipconfigname" {
    type = string
    description = "provide ip config name"
}

variable "vmname" {
    type = string
    description = "provide vmname"
}

variable "vmsize" {
    description = "provide ip size"
    type = string   
}

variable "admin_password" {
  type = string
  description = "Password for admin account"  
}

variable "admin_username" {
  type = string
  description = "name of admin"
}

variable "computer_name" {
  type = string
  description = "computer name"
  
}

variable "os_disk" {
  type = object({
    name = string
    storage_account_type = string
    caching = string
  })
  description = "provide os disk details"
}

variable "source_image_reference" {
  type = object({
    publisher = string
    offer = string
    sku = string
    version = string 
  })
  description = "provide source image reference"
}

variable "publicIpName" {
  type = string
  description = "provide IP Name"
}

variable "publicIp_allocation_method" {
  type = string
  description = "provide allocation method"
}




