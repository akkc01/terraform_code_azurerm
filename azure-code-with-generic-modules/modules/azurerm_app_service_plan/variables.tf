variable "app_service_plans" {
  type = map(object({
    asp_name = string
    location = string
    sku_tier = string
    sku_size = string
    rg_key = string
  }))
}

variable "rg_name" {
  description = "Map of RG names from RG module"
  type        = map(string)
}