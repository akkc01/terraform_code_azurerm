variable "rgs" {
  description = "used for rg"
  type = map(object({
    name     = string
    location = string
    tags     = optional(map(string))
  }))

  default = {
    rg1 = {
      name     = "maneesh-rg-007-var"
      location = "eastus"
      tags = {
        environment = "dev-rvar"
        owner       = "maneesh-rvar"
        team        = "alpha-team-rvar"
      }
    }
  }
}
