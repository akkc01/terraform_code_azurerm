resource "azurerm_lb_backend_address_pool" "bepool" {
  name               = var.backend_pool_name
  loadbalancer_id    = data.azurerm_lb.lb.id

  # ❌ Don't specify virtual_network_id
  #virtual_network_id = data.azurerm_virtual_network.vnet.id  -** use when IP-based association
}

