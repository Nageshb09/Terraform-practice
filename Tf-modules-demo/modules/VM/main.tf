
resource "azurerm_resource_group" "rg" {
    name = var.rgname
    location = var.rglocation
}

resource "azurerm_virtual_network" "vnet" {
    name = var.vnetname
    address_space = var.vnetaddrspace
    location = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name  
}

resource "azurerm_subnet" "subnet" {
    name = var.subnetname
    resource_group_name = azurerm_resource_group.rg.name
    virtual_network_name = azurerm_virtual_network.vnet.name
    address_prefixes = var.subnetprefixes
}

resource "azurerm_public_ip" "publicIp" {
  name = var.publicIpName
  resource_group_name = azurerm_resource_group.rg.name
  location = azurerm_resource_group.rg.location 
  allocation_method = var.publicIp_allocation_method
}

resource "azurerm_network_interface" "nic" {
    name = var.netinterfacename
    location = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name
    ip_configuration {
      name = var.ipconfigname
      subnet_id = azurerm_subnet.subnet.id
      private_ip_address_allocation = var.ipallocation
      public_ip_address_id = azurerm_public_ip.publicIp.id 
    }
}

resource "azurerm_network_security_group" "nsg" {
  name                = "nsg-flask"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  security_rule {
    name                       = "SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "HTTP"
    priority                   = 1002
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "8200"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_subnet_network_security_group_association" "nsg_assoc" {
  subnet_id                 = azurerm_subnet.subnet.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}


resource "azurerm_linux_virtual_machine" "vm" {
  name = var.vmname
  resource_group_name = azurerm_resource_group.rg.name
  location = azurerm_resource_group.rg.location
  size = var.vmsize
  admin_username = var.admin_username
  admin_password = var.admin_password
  computer_name = var.computer_name
  network_interface_ids = [azurerm_network_interface.nic.id]
  
  os_disk {
    name = var.os_disk.name
    storage_account_type = var.os_disk.storage_account_type
    caching = var.os_disk.caching
  }
  
  
  source_image_reference {
    publisher = var.source_image_reference.publisher
    offer = var.source_image_reference.offer
    sku = var.source_image_reference.sku
    version = var.source_image_reference.version
  }

  tags = {
    "environment"="dev"
    "owner"="naveen"
  }

  disable_password_authentication = false

}

