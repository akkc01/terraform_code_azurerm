
resource "azurerm_network_interface_backend_address_pool_association" "asso1" {
  network_interface_id = data.azurerm_network_interface.vmnic1.id
  # yahan nic me jo ip_configuration_name hai uska naam dena hai
  ip_configuration_name   = var.ip_configuration_name
  backend_address_pool_id = data.azurerm_lb_backend_address_pool.bepool.id
}


resource "azurerm_network_interface_backend_address_pool_association" "asso2" {
  network_interface_id = data.azurerm_network_interface.vmnic2.id
  # yahan nic me jo ip_configuration_name hai uska naam dena hai
  ip_configuration_name   = var.ip_configuration_name
  backend_address_pool_id = data.azurerm_lb_backend_address_pool.bepool.id
}
