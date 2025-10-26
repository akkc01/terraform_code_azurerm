resource "azurerm_virtual_network" "vnet" {
  for_each = var.virtual_networks

  name                           = each.value.vnet_name
  resource_group_name            = var.rg_names[each.value.rg_key]
  location                       = var.rg_locations[each.value.rg_key]
  address_space                  = lookup(each.value, "address_space", null)
  bgp_community                  = lookup(each.value, "bgp_community", null)
  dns_servers                    = lookup(each.value, "dns_servers", [])
  edge_zone                      = lookup(each.value, "edge_zone", null)
  flow_timeout_in_minutes        = lookup(each.value, "flow_timeout_in_minutes", null)
  private_endpoint_vnet_policies = lookup(each.value, "private_endpoint_vnet_policies", "Disabled")
  tags                           = lookup(each.value, "tags", {})


#  1st way conditional(ternarry operator)--

#   dynamic "ip_address_pool" {
#     for_each = each.value.ip_address_pools == null ? [] : each.value.ip_address_pools
#     content {
#       id                     = ip_address_pool.value.id
#       number_of_ip_addresses = ip_address_pool.value.number_of_ip_addresses
#     }
#   }


# 2nd way for_each with null value paas in variable--

# iske variable me hi default value de di hai to null nahi aayega
  dynamic "ip_address_pool" {
    for_each = each.value.ip_address_pools
    content {
      id                     = ip_address_pool.value.id
      number_of_ip_addresses = ip_address_pool.value.number_of_ip_addresses
    }
  }


# 3rd way for_each with lookup()--
# Best jab: hum map ke andar optional key/values access kar raha hai.

#   dynamic "ip_address_pool" {
#     for_each = lookup(each.value, "ip_address_pools", [])
#     content {
#       id                     = ip_address_pool.value.id
#       number_of_ip_addresses = ip_address_pool.value.number_of_ip_addresses
#     }
#   }


# 4th way for_each with coalesce--

# dynamic "ip_address_pool" {
#   for_each = coalesce(each.value.ip_address_pools, [])
#   content {
#     id                     = ip_address_pool.value.id
#     number_of_ip_addresses = ip_address_pool.value.number_of_ip_addresses
#   }
# }


# 5th way for_each with try()--

# dynamic "ip_address_pool" {
#   for_each = try(each.value.ip_address_pools, [])
#   content {
#     id                     = ip_address_pool.value.id
#     number_of_ip_addresses = ip_address_pool.value.number_of_ip_addresses
#   }
# }

# 6th way for_each with can()--

# dynamic "ip_address_pool" {
#   for_each = can(each.value.ip_address_pools) ? each.value.ip_address_pools : []
#   content {
#     id                     = ip_address_pool.value.id
#     number_of_ip_addresses = ip_address_pool.value.number_of_ip_addresses
#   }
# }

# 7th way by default without dynamic block--
#   ip_address_pool {
#       id                     = ip_address_pool.value.id
#       number_of_ip_addresses = ip_address_pool.value.number_of_ip_addresses
#   }



  dynamic "ddos_protection_plan" {
    for_each = each.value.ddos_protection_plan != null ? each.value.ddos_protection_plan : {}
    content {
      id     = ddos_protection_plan.value.id
      enable = ddos_protection_plan.value.enable
    }
  }


  dynamic "encryption" {
    for_each = each.value.encryption != null ? [each.value.encryption] : []
    content {
      enforcement = encryption.value.enforcement
    }
  }


  dynamic "subnet" {
    for_each = lookup(each.value, "subnets", [])
    content {
      name                                          = subnet.value.name
      address_prefixes                              = subnet.value.address_prefixes
      security_group                                = lookup(subnet.value, "security_group", null)
      default_outbound_access_enabled               = lookup(subnet.value, "default_outbound_access_enabled", true)
      private_endpoint_network_policies             = lookup(subnet.value, "private_endpoint_network_policies", "Disabled")
      private_link_service_network_policies_enabled = lookup(subnet.value, "private_link_service_network_policies_enabled", true)
      route_table_id                                = lookup(subnet.value, "route_table_id", null)
      service_endpoints                             = lookup(subnet.value, "service_endpoints", [])
      service_endpoint_policy_ids                   = lookup(subnet.value, "service_endpoint_policy_ids", [])

      dynamic "delegation" {
        for_each = lookup(subnet.value, "delegations", [])
        content {
          name = delegation.value.name

          dynamic "service_delegation" {
            for_each = lookup(delegation.value, "service_delegation", [])
            content {
              name    = service_delegation.value.name
              actions = lookup(service_delegation.value, "actions", [])
            }

          }
        }
      }
    }
  }
}
