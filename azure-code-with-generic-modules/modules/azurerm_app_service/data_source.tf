data "azurerm_app_service_plan" "asp" {
  for_each = var.app_services

  name                = each.value.asp_name
  resource_group_name = each.value.rg_name
}