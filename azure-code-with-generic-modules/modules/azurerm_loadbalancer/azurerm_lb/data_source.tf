data "azurerm_public_ip" "lb_pip" {
  for_each = var.load_balancers
  name                = each.key.lb_pip_name
  resource_group_name = var.rg_name[each.value.rg_key]
}
