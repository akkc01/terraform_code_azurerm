data "azurerm_network_security_group" "nsg1" {
  name                = var.nsg_name
  resource_group_name = var.rg_name
}

data "azurerm_subnet" "subnet" {
  name                 = var.appgw_subnet_name
  virtual_network_name = var.vnet_name
  resource_group_name  = var.rg_name
  
}

