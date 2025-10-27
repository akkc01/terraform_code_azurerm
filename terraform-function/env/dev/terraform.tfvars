resource_groups = {
  rg1 = {
    rg_name    = "Avengers-rg-001"
    location   = "brazilsouth"
    managed_by = "IRON-MAN-team"
    tags = {
      environment = "production"
      owner       = "Lead-by-tonystark"
      team        = "Avengers"
    }
  }
  rg2 = {
    rg_name    = "New-Avengers-rg-001"
    location   = "canadaeast"
    managed_by = "Captain Marvel-team"
    tags = {
      environment = "development"
      owner       = "Lead-by-Carol-Danvers"
      team        = "New-Avengers"
    }
  }
}

virtual_networks = {
  vnet-dev1 = {
    vnet_name                      = "vnet-dev01"
    rg_key                         = "rg1"
    # yaha pe rg aur location ki values blank/empty h, because ye values module ke through aa rhi hain
    location                       = ""
    resource_group_name            = ""
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
        name                                          = "vnet-dev01-subnet01"
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
        name                                          = "vnet-dev01-subnet02"
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

  vnet-dev2 = {
    vnet_name                      = "vnet-dev02"
    # yaha pe rg aur location ki values blank/empty h, because ye values module ke through aa rhi hain
    rg_key                         = "rg1"
    location                       = ""
    resource_group_name            = ""
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
        name                                          = "vnet-dev02-subnet1"
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
        name                                          = "vnet-dev02-subnet2"
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

  vnet-prod = {
    vnet_name                      = "vnet-prod01"
    # yaha pe rg aur location ki values blank/empty h, because ye values module ke through aa rhi hain
    location                       = ""
    resource_group_name            = ""
    rg_key                         = "rg1"
    address_space                  = ["10.12.0.0/16"]
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
        name                                          = "vnet-prod01-subnet01"
        address_prefixes                              = ["10.12.1.0/24"]
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
        name                                          = "vnet-prod01-subnet02"
        address_prefixes                              = ["10.12.2.0/24"]
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
    # yaha pe rg aur location ki values blank/empty h, because ye values module ke through aa rhi hain
    location                       = ""
    resource_group_name            = ""
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

