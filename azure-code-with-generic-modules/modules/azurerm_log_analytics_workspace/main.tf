resource "azurerm_log_analytics_workspace" "law" {
  for_each = var.log_analytics_workspaces

  name                = "${each.key}-log-analytics"
  location            = each.value.location
  resource_group_name = each.value.rr_name
  sku                 = each.value.sku
  retention_in_days   = each.value.retention_in_days
}

