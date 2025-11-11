variable "container_app_environments" {
  type = map(object({
    location                   = string
    resource_group_name        = string
    log_analytics_workspace_id = string
  }))

  default = {
    env1 = {
      location                   = "East US"
      resource_group_name        = "rg-apps-east"
    }
    env2 = {
      location                   = "West Europe"
      resource_group_name        = "rg-apps-eu"
    }
  }
}