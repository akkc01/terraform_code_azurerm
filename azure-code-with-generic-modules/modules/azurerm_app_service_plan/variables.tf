variable "app_service_plans" {
  type = map(object({
    location = string
    sku_tier = string
    sku_size = string
  }))
  
  default = {
    plan1 = {
      location = "East US"
      sku_tier = "Standard"
      sku_size = "S1"
    }
    plan2 = {
      location = "West Europe"
      sku_tier = "PremiumV2"
      sku_size = "P1v2"
    }
  }
}