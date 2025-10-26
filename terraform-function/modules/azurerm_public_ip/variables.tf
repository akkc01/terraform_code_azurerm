variable "public_ips" {
  description = "Map of Public IP configurations"
  type = map(object({
    pip_name                = string
    resource_group_name     = string
    location                = string
    rg_key                  = string
    allocation_method       = string
    zones                   = optional(list(string))
    ddos_protection_mode    = optional(string, "VirtualNetworkInherited")
    ddos_protection_plan_id = optional(string)
    domain_name_label       = optional(string)
    domain_name_label_scope = optional(string)
    edge_zone               = optional(string)
    idle_timeout_in_minutes = optional(number)
    ip_tags                 = optional(map(string))
    ip_version              = optional(string, "IPv4")
    public_ip_prefix_id     = optional(string)
    reverse_fqdn            = optional(string)
    sku                     = optional(string, "Standard")
    sku_tier                = optional(string, "Regional")
    tags                    = optional(map(string))
  }))
}


variable "rg_names" {
  description = "Map of RG names from RG module"
  type        = map(string)
}

variable "rg_locations" {
  description = "Map of RG locations from RG module"
  type        = map(string)
}
