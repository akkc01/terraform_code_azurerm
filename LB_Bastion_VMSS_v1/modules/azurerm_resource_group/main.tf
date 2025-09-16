resource "azurerm_resource_group" "rg1" {
  name     = "dev-${var.rg_name}-${var.location}"
  location = var.location
}


