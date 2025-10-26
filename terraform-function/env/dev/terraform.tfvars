resource_groups = {
  rg1 = {
    rg_name    = "myrg-007"
    location   = "brazilsouth"
    managed_by = "TERRAFORM-team"
    tags = {
      environment = "dev"
      owner       = "alice"
      team        = "devops"
    }
  }
  rg2 = {
    rg_name    = "myrg-008"
    location   = "canadaeast"
    managed_by = "IRONMAN-team"
    tags = {
      environment = "prod"
      owner       = "jelina"
      team        = "production-team"
    }
  }
}

virtual_networks = {
  vnet-dev = {
    vnet_name                      = "vnet-dev"
    rg_key                         = "rg1"
    location                       = "West Europe"
    resource_group_name            = "rg-development"
    address_space                  = ["10.10.0.0/16"]
    dns_servers                    = []
    bgp_community                  = null
    edge_zone                      = null
    flow_timeout_in_minutes        = null
    private_endpoint_vnet_policies = "Basic"
    tags = {
      environment = "Development"
      owner       = "DevOps"
    }

    # ip_address_pools     = [{
    #     id                     = "/subscriptions/xxxx/resourceGroups/rg-development/providers/Microsoft.Network/ipAddressPools/pool1"
    #     number_of_ip_addresses = "100"
    # }]

    ddos_protection_plan = null
    encryption           = null

    subnets = [
      {
        name                                          = "dev-subnet1"
        address_prefixes                              = ["10.10.1.0/24"]
        security_group_id                             = null
        route_table_id                                = null
        service_endpoints                             = ["Microsoft.Storage"]
        service_endpoint_policy_ids                   = []
        default_outbound_access_enabled               = true
        private_endpoint_network_policies             = "Disabled"
        private_link_service_network_policies_enabled = true
        delegations                                   = []
      },
      {
        name                                          = "dev-subnet2"
        address_prefixes                              = ["10.10.2.0/24"]
        security_group_id                             = null
        route_table_id                                = null
        service_endpoints                             = ["Microsoft.Storage"]
        service_endpoint_policy_ids                   = []
        default_outbound_access_enabled               = true
        private_endpoint_network_policies             = "Disabled"
        private_link_service_network_policies_enabled = true
        delegations                                   = []
      }
    ]
  }
  vnet-prod = {
    vnet_name                      = "vnet-prod"
    location                       = "West Europe"
    resource_group_name            = "rg-prod"
    rg_key                         = "rg1"
    address_space                  = ["10.11.0.0/16"]
    dns_servers                    = []
    bgp_community                  = null
    edge_zone                      = null
    flow_timeout_in_minutes        = null
    private_endpoint_vnet_policies = "Basic"
    tags = {
      environment = "Development"
      owner       = "DevOps"
    }

    # ip_address_pools     = [{
    #     id                     = "/subscriptions/xxxx/resourceGroups/rg-development/providers/Microsoft.Network/ipAddressPools/pool1"
    #     number_of_ip_addresses = "100"
    # }]

    ddos_protection_plan = null
    encryption           = null

    subnets = [
      {
        name                                          = "prod-subnet1"
        address_prefixes                              = ["10.11.1.0/24"]
        security_group_id                             = null
        route_table_id                                = null
        service_endpoints                             = ["Microsoft.Storage"]
        service_endpoint_policy_ids                   = []
        default_outbound_access_enabled               = true
        private_endpoint_network_policies             = "Disabled"
        private_link_service_network_policies_enabled = true
        delegations                                   = []
      },
      {
        name                                          = "prod-subnet2"
        address_prefixes                              = ["10.11.2.0/24"]
        security_group_id                             = null
        route_table_id                                = null
        service_endpoints                             = ["Microsoft.Storage"]
        service_endpoint_policy_ids                   = []
        default_outbound_access_enabled               = true
        private_endpoint_network_policies             = "Disabled"
        private_link_service_network_policies_enabled = true
        delegations                                   = []
      }
    ]
  }
}

public_ips = {
  pip1 = {
    pip_name            = "prod-pip-01"
    rg_key              = "rg1"
    location            = "West Europe"
    resource_group_name = "rg-prod"
    allocation_method   = "Static"
    zones               = ["1", "2", "3"]
    # ddos_protection_mode    = "Enabled"
    # ddos_protection_plan_id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-prod-security/providers/Microsoft.Network/ddosProtectionPlans/ddos-plan-prod"
    # domain_name_label       = "prodweb01"
    # domain_name_label_scope = "SubscriptionReuse"
    # edge_zone               = null
    # idle_timeout_in_minutes = 15
    # ip_tags = {
    #   RoutingPreference = "Internet"
    # }
    # ip_version          = "IPv4"
    # public_ip_prefix_id = null
    # reverse_fqdn        = "prodweb01.contoso.com"
    sku      = "Standard"
    sku_tier = "Regional"
    tags = {
      environment = "Production"
      owner       = "DevOpsTeam"
      costcenter  = "CC1001"
    }
  }


}
