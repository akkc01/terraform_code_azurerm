data "azurerm_log_analytics_workspace" "law" {
  for_each = var.container_app_environments

  name                = each.value.law_name
  resource_group_name = var.rg_name[each.value.rg_key]
}
