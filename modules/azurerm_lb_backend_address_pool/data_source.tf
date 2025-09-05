data "azurerm_lb" "lb2" {
  name                = var.lb_name
  resource_group_name = var.rg_name
}

data "azurerm_virtual_network" "vnet2" {
  name                = var.vnet_name
  resource_group_name = var.rg_name
}