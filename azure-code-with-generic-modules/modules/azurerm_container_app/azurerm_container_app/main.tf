resource "azurerm_container_app" "conapp" {
  for_each = var.container_apps

  name                         = each.value.container_app_name
  resource_group_name          = var.rg_name[each.value.rg_key]
  container_app_environment_id = data.azurerm_container_app_environment.cappe[each.key].id
  revision_mode                = each.value.revision_mode

  template {
    container {
      name   = each.value.container.name
      image  = each.value.container.image
      cpu    = each.value.container.cpu
      memory = each.value.container.memory
    }
  }
}
