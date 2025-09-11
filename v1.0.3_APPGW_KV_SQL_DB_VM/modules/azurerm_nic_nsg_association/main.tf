
resource "azurerm_network_interface_security_group_association" "assoc3" {
  network_interface_id      = data.azurerm_network_interface.vm1_nic.id
  network_security_group_id = data.azurerm_network_security_group.nsg1.id
}

resource "azurerm_network_interface_security_group_association" "assoc4" {
  network_interface_id      = data.azurerm_network_interface.vm2_nic.id
  network_security_group_id = data.azurerm_network_security_group.nsg1.id
}

resource "azurerm_subnet_network_security_group_association" "nsg_assoc2" {
  # here we are asssociating subnet1 with nsg .
  subnet_id                 = data.azurerm_subnet.subnet.id
  network_security_group_id = data.azurerm_network_security_group.nsg1.id
}

# resource "azurerm_subnet_network_security_group_association" "nsg_assoc1" {
#   # here we are asssociating appgw subnet with nsg .
#   subnet_id                 = data.azurerm_subnet.appgw_subnet.id
#   network_security_group_id = data.azurerm_network_security_group.nsg1.id
# }