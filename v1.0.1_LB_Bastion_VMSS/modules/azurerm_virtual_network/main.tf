resource "azurerm_virtual_network" "vnet1" {
  name                = "dev-${var.vnet_name}-${var.location}"
  location            = var.location
  resource_group_name = var.rg_name
  address_space       = var.address_space
}

