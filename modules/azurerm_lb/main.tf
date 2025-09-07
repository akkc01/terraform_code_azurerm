resource "azurerm_lb" "lb" {
  name                = var.lb_name
  location            = var.location
  resource_group_name = var.rg_name
  sku                 = var.sku

  frontend_ip_configuration {
    name                          = var.frontend_ip_name
    public_ip_address_id          = data.azurerm_public_ip.lb_pip1.id
    private_ip_address_allocation = "Dynamic"

  }
}

