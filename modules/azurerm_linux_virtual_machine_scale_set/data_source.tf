data "azurerm_subnet" "vmss_sub7" {
  name                 = var.vmss_sub7
  virtual_network_name = var.vnet_name
  resource_group_name  = var.rg_name
}

data "azurerm_lb" "lb4" {
  name                = var.lb_name
  resource_group_name = var.rg_name
}


data "azurerm_lb_backend_address_pool" "bepool3" {
  name            = var.backend_pool_name
  loadbalancer_id = data.azurerm_lb.lb4.id
}

data "azurerm_network_security_group" "nsg1" {
  name                = var.nsg_name
  resource_group_name = var.rg_name
}