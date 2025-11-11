resource "azurerm_app_service" "example" {
  for_each = var.app_services

  name                = "${each.key}-app-service"
  location            = each.value.location
  resource_group_name = each.value.rg_name

  # Link with existing App Service Plan (data source)
  app_service_plan_id = data.azurerm_app_service_plan.asp[each.key].id

  site_config {
    dotnet_framework_version = each.value.site_config.dotnet_version
    scm_type                 = each.value.site_config.scm_type
  }

  app_settings = each.value.app_settings

  connection_string {
    name  = each.value.connection_string.name
    type  = each.value.connection_string.type
    value = each.value.connection_string.value
  }
}
