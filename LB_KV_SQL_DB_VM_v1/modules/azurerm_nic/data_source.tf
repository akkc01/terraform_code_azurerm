
data "azurerm_subnet" "vm_sub" {
  name                 = var.vm_sub
  virtual_network_name = var.vnet_name
  resource_group_name  = var.rg_name
}

