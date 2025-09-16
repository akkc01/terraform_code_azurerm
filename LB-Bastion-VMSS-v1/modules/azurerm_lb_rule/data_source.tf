data "azurerm_lb" "lb4" {
  name                = var.lb_name
  resource_group_name = var.rg_name
}


data "azurerm_lb_backend_address_pool" "bepool2" {
  name            = var.backend_pool_name
  loadbalancer_id = data.azurerm_lb.lb4.id
}

