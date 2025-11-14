# 

resource "azurerm_service_plan" "this" {
  for_each = var.service_plans

  # Required
  name                = each.value.sp_name
  location            = each.value.location
  os_type             = each.value.os_type
  resource_group_name = var.rg_name[each.value.rg_key]
  sku_name            = each.value.sku_name

  # Optional
  app_service_environment_id      = lookup(each.value, "app_service_environment_id", null)
  premium_plan_auto_scale_enabled = lookup(each.value, "premium_plan_auto_scale_enabled", null)
  maximum_elastic_worker_count    = lookup(each.value, "maximum_elastic_worker_count", null)
  worker_count                    = lookup(each.value, "worker_count", null)
  per_site_scaling_enabled        = lookup(each.value, "per_site_scaling_enabled", null)
  zone_balancing_enabled          = lookup(each.value, "zone_balancing_enabled", null)
  tags                            = lookup(each.value, "tags", null)
}

