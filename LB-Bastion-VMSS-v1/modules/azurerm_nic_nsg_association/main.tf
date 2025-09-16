# resource "azurerm_network_interface_security_group_association" "assoc1" {
#   network_interface_id      = data.azurerm_network_interface.bastion_nic2.id
#   network_security_group_id = data.azurerm_network_security_group.nsg1.id
# }

resource "azurerm_network_interface_security_group_association" "assoc2" {
  network_interface_id      = data.azurerm_network_interface.lb_nic2.id
  network_security_group_id = data.azurerm_network_security_group.nsg1.id
}