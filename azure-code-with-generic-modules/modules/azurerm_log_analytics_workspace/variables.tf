variable "log_analytics_workspaces" {
  type = map(object({
    location          = string
    resource_group    = string
    sku               = string
    retention_in_days = number
  }))

  default = {
    workspace1 = {
      location          = "East US"
      resource_group    = "rg-logging-east"
      sku               = "PerGB2018"
      retention_in_days = 30
    }
    workspace2 = {
      location          = "West Europe"
      resource_group    = "rg-logging-eu"
      sku               = "PerGB2018"
      retention_in_days = 60
    }
  }
}
