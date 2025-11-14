variable "container_apps" {
  type = map(object({
    container_app_name           = string
    rg_key                       = string
    revision_mode                = string
    conappenv_name = string
    container = object({
      name   = string
      image  = string
      cpu    = number
      memory = string
    })
  }))
}

variable "rg_name" {
  description = "Map of RG names from RG module"
  type        = map(string)
}
