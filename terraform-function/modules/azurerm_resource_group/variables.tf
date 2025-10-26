variable "resource_groups" {
  description = "variable for rg"
  type = map(object({
    rg_name    = string
    location   = string
    managed_by = optional(string)
    tags       = optional(map(string))
    # tags = map(object({
    #   environment = string
    #   owner       = string
    #   team        = string
    # }))
  }))
}
