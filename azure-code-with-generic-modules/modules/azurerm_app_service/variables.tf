variable "app_services" {
  type = map(object({
    app_service_plan_key = string
    dotnet_version       = string
    scm_type             = string
    asp_name             = string
    appservice_name      = string
    rg_key               = string
    app_settings         = map(string)
  }))
}

variable "rg_name" {
  description = "Map of RG names from RG module"
  type        = map(string)
}
