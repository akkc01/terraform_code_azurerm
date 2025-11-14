data "azurerm_service_plan" "sp" {
  for_each = var.app_services

  name                = each.value.sp_name
  resource_group_name = var.rg_name[each.value.rg_key]
}