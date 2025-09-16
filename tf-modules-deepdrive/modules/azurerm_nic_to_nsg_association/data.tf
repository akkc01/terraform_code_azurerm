data "azurerm_network_security_group" "nsg1" {
  name                = var.nsg_name
  resource_group_name = var.rg_name
}

data "azurerm_network_interface" "bastion_nic2" {
  name                = var.nic_name
  resource_group_name = var.rg_name
}


