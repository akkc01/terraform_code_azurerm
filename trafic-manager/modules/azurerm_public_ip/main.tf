# resource "azurerm_public_ip" "bastion_pip" {
#   name                = var.bastion_pip_name
#   resource_group_name = var.rg_name
#   location            = var.location
#   allocation_method   = var.allocation_method
#   sku                 = var.sku
# }


# resource "azurerm_public_ip" "lb_pip" {
#   name                = var.lb_pip_name
#   resource_group_name = var.rg_name
#   location            = var.location
#   allocation_method   = var.allocation_method
#   sku                 = var.sku
# }

resource "azurerm_public_ip" "appgw_pip" {
  name                = var.appgw_pip_name
  resource_group_name = var.rg_name
  location            = var.location
  allocation_method   = var.allocation_method
  sku                 = var.sku
}