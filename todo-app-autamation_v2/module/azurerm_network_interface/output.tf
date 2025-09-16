output "fvm_nic_id" {
  value = azurerm_network_interface.fvm_nic.id
}
output "fvm_nic_name" {
  value = azurerm_network_interface.fvm_nic.name
  
}

output "bvm_nic_id" {
  value = azurerm_network_interface.bvm_nic.id
}
output "bvm_nic_name" {
  value = azurerm_network_interface.bvm_nic.name
  
}

output "fvm_private_ip" {
  value = azurerm_network_interface.fvm_nic.ip_configuration[0].private_ip_address
}

output "bvm_private_ip" {
  value = azurerm_network_interface.bvm_nic.ip_configuration[0].private_ip_address
}
