variable "subscription_id" {
  description = "your-subscription-id-here"
  default     = "b398fea1-2f06-4948-924a-121d4ed265b0"
}

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


variable "virtual_networks" {
  description = "Map of Azure Virtual Networks with all supported properties."
  type = map(object({
    vnet_name           = string
    location            = string
    resource_group_name = string
    rg_key              = string

    # Exactly one of these should be set by user
    address_space                  = optional(list(string), null)
    bgp_community                  = optional(string, null)
    dns_servers                    = optional(list(string), [])
    edge_zone                      = optional(string, null)
    flow_timeout_in_minutes        = optional(number, null)
    private_endpoint_vnet_policies = optional(string, "Disabled")
    tags                           = optional(map(string), {})

    ip_address_pools = optional(list(object({
      id                     = string
      number_of_ip_addresses = string
    })), [])


    ddos_protection_plan = optional(object({
      id     = string
      enable = bool
    }), null)


    encryption = optional(object({
      enforcement = string
    }), null)


    subnets = optional(list(object({
      name                                          = string
      address_prefixes                              = list(string)
      security_group_id                             = optional(string)
      route_table_id                                = optional(string)
      service_endpoints                             = optional(list(string), [])
      service_endpoint_policy_ids                   = optional(list(string), [])
      default_outbound_access_enabled               = optional(bool, true)
      private_endpoint_network_policies             = optional(string, "Disabled")
      private_link_service_network_policies_enabled = optional(bool, true)

      delegations = optional(list(object({
        name = string
        service_delegation = object({
          name    = string
          actions = optional(list(string), [])
        })
      })), [])
    })), [])
  }))
}


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
