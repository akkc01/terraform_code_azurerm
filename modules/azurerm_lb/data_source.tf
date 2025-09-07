data "azurerm_public_ip" "lb_pip1" {
  name                = var.lb_pip_name1
  resource_group_name = var.rg_name
}


data "azurerm_virtual_network" "vnet1" {
  name                = var.vnet_name1
  resource_group_name = var.rg_name
}

