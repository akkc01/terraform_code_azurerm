
resource "azurerm_public_ip" "appgw_pip" {
  name                = var.appgw_pip_name
  resource_group_name = var.rg_name
  location            = var.location
  allocation_method   = var.allocation_method
  sku                 = var.sku
  domain_name_label = var.domain_name_label
}