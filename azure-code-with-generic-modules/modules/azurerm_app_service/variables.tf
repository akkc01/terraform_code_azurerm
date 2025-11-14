variable "app_services" {
  description = "Map of App Service configurations"
  type = map(object({
    appservice_name = string
    location        = string
    rg_key          = string
    sp_name        = string
    site_config = optional(object({
      always_on                = optional(bool)
      app_command_line         = optional(string)
      auto_swap_slot_name      = optional(string)
      default_documents        = optional(list(string))
      dotnet_framework_version = optional(string)
      ftps_state               = optional(string)
      health_check_path        = optional(string)
      http2_enabled            = optional(bool)
      ip_restriction = optional(list(object({
        ip_address                = optional(string)
        service_tag               = optional(string)
        virtual_network_subnet_id = optional(string)
        name                      = optional(string)
        priority                  = optional(number)
        action                    = optional(string)
      })))
      scm_use_main_ip_restriction = optional(bool)
      scm_type                    = optional(string)
      java_version                = optional(string)
      java_container              = optional(string)
      java_container_version      = optional(string)
      linux_fx_version            = optional(string)
      managed_pipeline_mode       = optional(string)
      min_tls_version             = optional(string)
      number_of_workers           = optional(number)
      php_version                 = optional(string)
      python_version              = optional(string)
      remote_debugging_enabled    = optional(bool)
      remote_debugging_version    = optional(string)
      use_32_bit_worker_process   = optional(bool)
      vnet_route_all_enabled      = optional(bool)
      websockets_enabled          = optional(bool)
    }))

    app_settings = map(string)

    connection_string = optional(object({
      name  = string
      type  = string
      value = string
    }))
  }))
}

variable "rg_name" {
  description = "Map of RG names from RG module"
  type        = map(string)
}
