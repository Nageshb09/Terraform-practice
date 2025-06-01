variable "vmsize" {
  type = map(string)
  description = "VM size map per workspace"
  default = {
    "dev"   = "Standard_F2"
    "stage" = "Standard_B1s"
    "prod"  = "Standard_D2s_v3"
  }
}

variable "rgname" {
  description = "name of RG"
  type = map(string)
  default = {
    "dev" = "devrg"
    "stage" = "stagerg"
    "prod" = "prodrg"
  }
}

variable "storage_account_name" {
    description = "provide SA name"
    type = map(string)
    default = {
      "dev" = "devstorageaccountt"
      "stage" = "stagestorageaccountt"
      "prod" = "prodstorageaccountt"
     }
}