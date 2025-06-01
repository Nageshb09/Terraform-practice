

output "rgname" {
  value = azurerm_resource_group.rg.name
}

output "vm_name" {
    value = azurerm_linux_virtual_machine.vm
}

/*
output "hostname" {
    value = azurerm_virtual_machine.vm.os_profile.computer_name
}
*/

output "private_ip" {
    value = azurerm_network_interface.nic.private_ip_address
}