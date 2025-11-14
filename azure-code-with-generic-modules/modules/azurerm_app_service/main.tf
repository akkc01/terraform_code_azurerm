resource "azurerm_app_service" "example" {
  for_each = var.app_services

  name                = each.value.appservice_name
  location            = each.value.location
  resource_group_name = var.rg_name[each.value.rg_key]
  app_service_plan_id = data.azurerm_service_plan.sp[each.key].id

# site_config block (full support)
  site_config {
    always_on                = try(each.value.site_config.always_on, false)
    app_command_line         = try(each.value.site_config.app_command_line, null)
    auto_swap_slot_name      = try(each.value.site_config.auto_swap_slot_name, null)
    default_documents        = try(each.value.site_config.default_documents, null)
    dotnet_framework_version = try(each.value.site_config.dotnet_framework_version, "v4.0")
    ftps_state               = try(each.value.site_config.ftps_state, "Disabled")
    health_check_path        = try(each.value.site_config.health_check_path, null)
    http2_enabled            = try(each.value.site_config.http2_enabled, false)
    scm_type                 = try(each.value.site_config.scm_type, "None")
    java_version             = try(each.value.site_config.java_version, null)
    java_container           = try(each.value.site_config.java_container, null)
    java_container_version   = try(each.value.site_config.java_container_version, null)
    linux_fx_version         = try(each.value.site_config.linux_fx_version, null)
    managed_pipeline_mode    = try(each.value.site_config.managed_pipeline_mode, "Integrated")
    min_tls_version          = try(each.value.site_config.min_tls_version, "1.2")
    number_of_workers        = try(each.value.site_config.number_of_workers, null)
    php_version              = try(each.value.site_config.php_version, null)
    python_version           = try(each.value.site_config.python_version, null)
    remote_debugging_enabled = try(each.value.site_config.remote_debugging_enabled, false)
    remote_debugging_version = try(each.value.site_config.remote_debugging_version, null)
    use_32_bit_worker_process = try(each.value.site_config.use_32_bit_worker_process, true)
    vnet_route_all_enabled   = try(each.value.site_config.vnet_route_all_enabled, false)
    websockets_enabled       = try(each.value.site_config.websockets_enabled, false)
  }

  app_settings = try(each.value.app_settings, {})

  dynamic "connection_string" {
    for_each = try(each.value.connection_strings, [])
    content {
      name  = connection_string.value.name
      type  = connection_string.value.type
      value = connection_string.value.value
    }
  }

  tags = {
    Environment = "Demo"
    ManagedBy   = "Terraform"
  }
}
