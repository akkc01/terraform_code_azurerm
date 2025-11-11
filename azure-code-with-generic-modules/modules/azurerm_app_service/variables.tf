variable "app_services" {
  type = map(object({
    app_service_plan_key = string
    dotnet_version       = string
    scm_type             = string
    asp_name             = string
    rg_name              = string
    app_settings         = map(string)
  }))

  default = {
    webapp1 = {
      app_service_plan_key = "plan1"
      dotnet_version       = "v4.0"
      scm_type             = "LocalGit"
      app_settings = {
        "SOME_KEY" = "value1"
      }
    }
    
    webapp2 = {
      app_service_plan_key = "plan2"
      dotnet_version       = "v6.0"
      scm_type             = "None"
      app_settings = {
        "SOME_KEY" = "value2"
      }
    }
  }
}
