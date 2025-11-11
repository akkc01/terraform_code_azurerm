resource "azurerm_app_service_plan" "asp" {
  for_each = var.app_service_plans

  name                = "${each.key}-appserviceplan"
  location            = each.value.location
  resource_group_name = each.value.rg_name

  sku {
    tier = each.value.sku_tier
    size = each.value.sku_size
  }
}

