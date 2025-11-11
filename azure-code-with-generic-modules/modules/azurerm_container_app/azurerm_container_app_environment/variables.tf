variable "container_app_environments" {
  type = map(object({
    location       = string
    rg_key         = string
    conappenv_name = string
    law_name       = string
  }))
}

variable "rg_name" {
  description = "Map of RG names from RG module"
  type        = map(string)
}
