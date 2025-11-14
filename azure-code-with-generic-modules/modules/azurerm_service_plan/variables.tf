
variable "service_plans" {
  type = map(object({
    # Required
    sp_name             = string
    location            = string
    os_type             = string
    sku_name            = string
    rg_key              = string

    # Optional
    app_service_environment_id      = optional(string)
    premium_plan_auto_scale_enabled = optional(bool)
    maximum_elastic_worker_count    = optional(number)
    worker_count                    = optional(number)
    per_site_scaling_enabled        = optional(bool)
    zone_balancing_enabled          = optional(bool)
    tags                            = optional(map(string))
  }))
}

variable "rg_name" {
  description = "Map of RG names from RG module"
  type        = map(string)
}