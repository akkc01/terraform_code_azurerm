resource "azurerm_lb_backend_address_pool" "bepool1" {
  name               = var.backend_pool_name
  loadbalancer_id    = data.azurerm_lb.lb2.id
  virtual_network_id = data.azurerm_virtual_network.vnet2.id
}
