variable "rgs" {
  description = "used for rg"
  type = map(object({
    name     = string
    location = string
    tags     = optional(map(string))
  }))

  default = {
    rg1 = {
      name     = "maneesh-rg-007"
      location = "eastus"
      tags = {
        environment = "dev-cvar"
        owner       = "maneesh-cvar"
        team        = "alpha-team-cvar"
      }
    }
  }
}
