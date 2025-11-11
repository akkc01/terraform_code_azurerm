resource "azurerm_app_service_plan" "asp" {
  for_each = var.app_service_plans

  name                = each.value.asp_name
  location            = each.value.location
  resource_group_name = var.rg_name[each.value.rg_key]

  sku {
    tier = each.value.sku_tier
    size = each.value.sku_size
  }
}

