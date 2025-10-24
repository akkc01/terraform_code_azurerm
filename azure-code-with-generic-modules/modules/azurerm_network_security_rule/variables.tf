variable "nsg" {
  description = "Map of NSGs with their location and rules"
  type = map(object({
    nsg_name            = string
    resource_group_name = string
    location            = string
    tags                = optional(map(string), {})
    security_rule = list(object({
      name                                       = string
      priority                                   = number
      direction                                  = string
      access                                     = string
      protocol                                   = string
      source_port_range                          = optional(string)
      destination_port_range                     = optional(string)
      source_address_prefix                      = optional(string)
      destination_address_prefix                 = optional(string)
      description                                = optional(string)
      source_application_security_group_ids      = optional(list(string))
      destination_application_security_group_ids = optional(list(string))
    }))
  }))
}
