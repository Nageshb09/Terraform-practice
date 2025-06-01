
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
    destination_port_range     = "80"
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


  connection {
      type = "ssh"
      user = self.admin_username
      password = self.admin_password
      host = self.public_ip_address
  }

  provisioner "file" {
    source = "${path.module}/app.py"
    destination = "/home/Naveen/app.py"
  }

  provisioner "remote-exec" {
    inline = [ 
      "set -x",
      "echo 'Hello from the remote instance'",
      "sudo apt update -y",  # Update package lists (for ubuntu)
      "sudo apt-get install -y python3-pip",  # Example package installation
      "cd /home/Naveen",
      "sudo pip3 install flask",
      "sudo python3 app.py &",
      
      #"sudo apt update -y",
      #"sudo apt install software-properties-common -y",
      #"sudo add-apt-repository --yes --update ppa:ansible/ansible",
      #"sudo apt install ansible -y"
     ]
  }
  depends_on = [ azurerm_public_ip.publicIp ]
  
}

