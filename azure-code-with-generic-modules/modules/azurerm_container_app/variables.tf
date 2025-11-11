variable "container_apps" {
  type = map(object({
    resource_group_name          = string
    container_app_environment_id = string
    revision_mode                = string
    container = object({
      name   = string
      image  = string
      cpu    = number
      memory = string
    })
  }))

  default = {
    app1 = {
      resource_group_name          = "rg-apps-east"
      revision_mode                = "Single"
      container = {
        name   = "frontend"
        image  = "mcr.microsoft.com/k8se/quickstart:latest"
        cpu    = 0.25
        memory = "0.5Gi"
      }
    }

    app2 = {
      resource_group_name          = "rg-apps-west"
      revision_mode                = "Single"
      container = {
        name   = "backend"
        image  = "mcr.microsoft.com/dotnet/samples:aspnetapp"
        cpu    = 0.5
        memory = "1Gi"
      }
    }
  }
}