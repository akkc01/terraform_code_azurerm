resource "azurerm_container_app_environment" "cappenv" {
  for_each = var.container_app_environments

  name                       = each.value.conappenv_name
  location                   = each.value.location
  resource_group_name          = var.rg_name[each.value.rg_key]
  log_analytics_workspace_id = data.azurerm.log_analytics_workspace.law[each.key].id
}

