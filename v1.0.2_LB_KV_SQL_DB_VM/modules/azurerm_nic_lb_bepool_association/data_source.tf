data "azurerm_network_interface" "vmnic1" {
  name                = var.vm1_nic_name
  resource_group_name = var.rg_name
  
}

data "azurerm_network_interface" "vmnic2" {
  name                = var.vm2_nic_name
  resource_group_name = var.rg_name
  
}

data "azurerm_lb" "lb" {
  name                = var.lb_name
  resource_group_name = var.rg_name
}


data "azurerm_lb_backend_address_pool" "bepool" {
  name               = var.backend_pool_name
  loadbalancer_id    = data.azurerm_lb.lb.id
}
