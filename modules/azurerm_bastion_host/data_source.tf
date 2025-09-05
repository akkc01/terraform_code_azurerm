data "azurerm_subnet" "bastion_sub4" {
  name                 = var.bastion_sub4
  virtual_network_name = var.vnet_name
  resource_group_name  = var.rg_name
}

data "azurerm_public_ip" "bastion_pip2" {
  name                = var.bastion_pip2_name
  resource_group_name = var.rg_name
}


