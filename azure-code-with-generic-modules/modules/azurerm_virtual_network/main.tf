resource "azurerm_virtual_network" "vnet" {
  for_each            = var.vnets
  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  address_space       = each.value.address_space
  dns_servers         = each.value.dns_servers
  bgp_community       = each.value.bgp_community
  edge_zone           = each.value.edge_zone
  flow_timeout_in_minutes = each.value.flow_timeout_in_minutes
  tags                = each.value.tags

  dynamic "ddos_protection_plan" {
    for_each = each.value.ddos_protection_plan != null ? [each.value.ddos_protection_plan] : []
    content {
      id     = ddos_protection_plan.value.id
      enable = try(ddos_protection_plan.value.enable, null)
    }
  }

  dynamic "ip_address_pool" {
    for_each = each.value.ip_address_pool != null ? values(each.value.ip_address_pool) : []
    content {
      id                     = ip_address_pool.value.id
      number_of_ip_addresses = try(ip_address_pool.value.number_of_ip_addresses, null)
    }
  }

  dynamic "subnet" {
    for_each = each.value.subnet != null ? values(each.value.subnet) : []
    content {
      name                             = subnet.value.name
      address_prefixes                 = subnet.value.address_prefixes
      security_group                   = try(subnet.value.security_group, null)
      default_outbound_access_enabled  = try(subnet.value.default_outbound_access_enabled, null)
      private_endpoint_network_policies             = try(subnet.value.private_endpoint_network_policies, null)
      private_link_service_network_policies_enabled = try(subnet.value.private_link_service_network_policies_enabled, null)
      route_table_id                                = try(subnet.value.route_table_id, null)
      service_endpoints                             = try(subnet.value.service_endpoints, null)
      service_endpoint_policy_ids                   = try(subnet.value.service_endpoint_policy_ids, null)

      dynamic "delegation" {
        for_each = subnet.value.delegation != null ? values(subnet.value.delegation) : []
        content {
          name = delegation.value.name

          dynamic "service_delegation" {
            for_each = delegation.value.service_delegation != null ? values(delegation.value.service_delegation) : []
            content {
              name    = service_delegation.value.name
              actions = try(service_delegation.value.actions, null)
            }
          }
        }
      }
    }
  }

  dynamic "encryption" {
    for_each = each.value.encryption != null ? [each.value.encryption] : []
    content {
      enforcement = encryption.value.enforcement
    }
  }

}
