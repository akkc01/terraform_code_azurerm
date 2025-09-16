resource "azurerm_public_ip" "bastion_pip1" {
  name                = var.bastion_pip1_name
  resource_group_name = var.rg_name
  location            = var.location
  allocation_method   = var.allocation_method
  sku                 = var.sku
}

resource "azurerm_public_ip" "lb_pip1" {
  name                = var.lb_pip1_name
  resource_group_name = var.rg_name
  location            = var.location
  allocation_method   = var.allocation_method
  sku                 = var.sku
}
