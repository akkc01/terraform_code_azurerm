data "azurerm_public_ip" "lb_pip2" {
  name                = var.lb_pip2_name
  resource_group_name = var.rg_name
}
