resource "azurerm_subnet_network_security_group_association" "nsg_assoc2" {
#   # here we are asssociating appgw subnet with nsg .
  subnet_id                 = data.azurerm_subnet.subnet.id
  network_security_group_id = data.azurerm_network_security_group.nsg1.id
}

