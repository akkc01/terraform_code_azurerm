resource "azurerm_container_app_environment" "cappenv" {
  for_each = var.container_app_environments

  name                       = "${each.key}-container-env"
  location                   = each.value.location
  resource_group_name        = each.value.rg_name
  log_analytics_workspace_id = data.azurerm.log_analytics_workspace.law[each.key].id
}

