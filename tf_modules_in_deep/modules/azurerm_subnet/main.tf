resource "azurerm_subnet" "sub1" {
  name                 = var.subnet1
  resource_group_name  = var.rg_name
  virtual_network_name = var.vnet_name
  address_prefixes     = var.subnet1_prefixes

}


resource "azurerm_subnet" "sub2" {
  name                 = var.subnet2
  resource_group_name  = var.rg_name
  virtual_network_name = var.vnet_name
  address_prefixes     = var.subnet2_prefixes

}


resource "azurerm_subnet" "sub3" {
  name                 = var.subnet3
  resource_group_name  = var.rg_name
  virtual_network_name = var.vnet_name
  address_prefixes     = var.subnet3_prefixes
}

