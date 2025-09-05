data "azurerm_subnet" "bastion_sub5" {
  name                 = var.bastion_sub5
  virtual_network_name = var.vnet_name
  resource_group_name  = var.rg_name
}

data "azurerm_subnet" "lb_sub6" {
  name                 = var.lb_sub6
  virtual_network_name = var.vnet_name
  resource_group_name  = var.rg_name
}

data "azurerm_public_ip" "bastion_pip1" {
  name                = var.bastion_pip1_name
  resource_group_name = var.rg_name
}

data "azurerm_public_ip" "lb_pip1" {
  name                = var.lb_pip1_name
  resource_group_name = var.rg_name
}

