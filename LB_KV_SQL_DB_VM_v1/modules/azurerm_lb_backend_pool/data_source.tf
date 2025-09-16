data "azurerm_lb" "lb" {
  name                = var.lb_name
  resource_group_name = var.rg_name
}

# data "azurerm_virtual_network" "vnet" {
#   name                = var.vnet_name
#   resource_group_name = var.rg_name
# }
