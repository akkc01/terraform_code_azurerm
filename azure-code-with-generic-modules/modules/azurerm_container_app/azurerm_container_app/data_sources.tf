data "azurerm_container_app_environment" "cappenv" {
  for_each = var.container_apps

  name                = each.value.conappenv_name
  resource_group_name = var.rg_name[each.value.rg_key]
}
