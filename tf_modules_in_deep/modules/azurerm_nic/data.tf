data "azurerm_subnet" "subnet5" {
  name                 = var.subnet5
  virtual_network_name = var.vnet_name
  resource_group_name  = var.rg_name
}
