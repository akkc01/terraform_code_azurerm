data "azurerm_container_app_environment" "cappenv" {
  for_each = var.container_apps

  name                = each.value.name
  resource_group_name = each.value.rg_name
}