variable "subscription_id" {}

variable "resource_groups" {
  description = "A map of resource groups to create. The key of the map will be used as the resource group identifier."
  type = map(object({
    name       = string
    location   = string
    managed_by = optional(string)
    tags       = optional(map(string), {})
  }))
}

variable "stgaccount" {
  description = "A map of storage accounts to create. The key of the map will be used as the storage account identifier."
  type = map(object({

    # Required Arguments
    name                     = string
    resource_group_name      = string
    location                 = string
    account_tier             = string
    account_replication_type = string

    # Optional Arguments
    account_kind                      = optional(string)
    provisioned_billing_model_version = optional(string)
    tags                              = optional(map(string))
    cross_tenant_replication_enabled  = optional(bool)
    access_tier                       = optional(string)
    edge_zone                         = optional(string)
    https_traffic_only_enabled        = optional(bool)
    min_tls_version                   = optional(string)
    allow_nested_items_to_be_public   = optional(bool)
    shared_access_key_enabled         = optional(bool)
    public_network_access_enabled     = optional(bool)
    default_to_oauth_authentication   = optional(bool)
    is_hns_enabled                    = optional(bool)
    nfsv3_enabled                     = optional(bool)
    large_file_share_enabled          = optional(bool)
    local_user_enabled                = optional(bool)
    queue_encryption_key_type         = optional(string)
    table_encryption_key_type         = optional(string)
    infrastructure_encryption_enabled = optional(bool)
    allowed_copy_scope                = optional(string)
    sftp_enabled                      = optional(bool)
    dns_endpoint_type                 = optional(string)


    # Block Arguments (Optional Arguments)
    custom_domain = optional(object({
      name          = string
      use_subdomain = optional(bool)
    }))

    customer_managed_key = optional(object({
      user_assigned_identity_id = string
      key_vault_key_id          = optional(string)
      managed_hsm_key_id        = optional(string)
    }))

    identity = optional(object({
      type         = string
      identity_ids = list(string)
    }))

    blob_properties = optional(object({
      cors_rule = optional(list(object({
        allowed_headers    = list(string)
        allowed_methods    = list(string)
        allowed_origins    = list(string)
        exposed_headers    = list(string)
        max_age_in_seconds = number
      })), [])
      delete_retention_policy = optional(object({
        days = number
      }), { days = 7 })
      restore_policy = optional(object({
        days = number
      }), { days = 7 })
      versioning_enabled            = optional(bool)
      change_feed_enabled           = optional(bool)
      change_feed_retention_in_days = optional(number)
      default_service_version       = optional(string)
      last_access_time_enabled      = optional(bool)
      container_delete_retention_policy = optional(object({
        days = optional(number)
      }))
    }))

    queue_properties = optional(object({
      cors_rule = optional(list(object({
        allowed_headers    = list(string)
        allowed_methods    = list(string)
        allowed_origins    = list(string)
        exposed_headers    = list(string)
        max_age_in_seconds = number
      })), [])
      logging = optional(object({
        delete                = bool
        read                  = bool
        write                 = bool
        version               = string
        retention_policy_days = optional(number)
      }))
      hour_metrics = optional(object({
        enabled               = bool
        version               = string
        include_apis          = optional(bool)
        retention_policy_days = optional(number)
      }))
      minute_metrics = optional(object({
        enabled               = bool
        version               = string
        include_apis          = optional(bool)
        retention_policy_days = optional(number)
      }))
    }))

    static_website = optional(object({
      index_document     = optional(string)
      error_404_document = optional(string)
    }))

    share_properties = optional(object({
      cors_rule = optional(list(object({
        allowed_headers    = list(string)
        allowed_methods    = list(string)
        allowed_origins    = list(string)
        exposed_headers    = list(string)
        max_age_in_seconds = number
      })), [])
      retention_policy = optional(object({
        days = number
      }))
      smb = optional(object({
        versions                        = list(string)
        authentication_types            = list(string)
        kerberos_ticket_encryption_type = string
        channel_encryption_type         = string
        multichannel_enabled            = bool
      }))
    }))

    network_rules = optional(object({
      default_action             = string
      bypass                     = optional(list(string), [])
      virtual_network_subnet_ids = optional(list(string), [])
      ip_rules                   = optional(list(string), [])
      private_link_access = optional(object({
        endpoint_resource_id = string
        endpoint_tenant_id   = optional(string)
      }))
    }))

    azure_files_authentication = optional(object({
      directory_type                 = optional(string)
      default_share_level_permission = optional(string)
      active_directory = object({
        domain_name         = optional(string)
        netbios_domain_name = optional(string)
        forest_name         = optional(string)
        domain_guid         = optional(string)
        domain_sid          = optional(string)
        storage_sid         = optional(string)
      })
      })
    )

    routing = optional(object({
      choice                      = string
      publish_microsoft_endpoints = bool
      publish_internet_endpoints  = bool
    }))

    immutability_policy = optional(object({
      state                         = string
      allow_protected_append_writes = bool
      period_since_creation_in_days = number
    }))

    sas_policy = optional(object({
      expiration_period = string
      expiration_action = string

    }))

  }))
}



variable "vnets" {
  description = "All the VNets"
  type = map(object({
    name                = string
    resource_group_name = string
    location            = string
    address_space       = optional(list(string))
    dns_servers         = optional(list(string))
    bgp_community       = optional(number)

    ddos_protection_plan = optional(object({
      id     = string
      enable = string
    }))

    edge_zone               = optional(string)
    flow_timeout_in_minutes = optional(string)

    ip_address_pool = optional(map(object({
      id                     = string
      number_of_ip_addresses = string
    })))

    subnet = optional(map(object({
      name                            = string
      address_prefixes                = list(string)
      security_group                  = optional(string)
      default_outbound_access_enabled = optional(bool)
      delegation = optional(map(object({
        name = string
        service_delegation = map(object({
          name    = string
          actions = optional(list(string))
        }))
      })))

      private_endpoint_network_policies             = optional(string)
      private_link_service_network_policies_enabled = optional(bool)
      route_table_id                                = optional(string)
      service_endpoints                             = optional(list(string))
      service_endpoint_policy_ids                   = optional(list(string))
    })))

    private_endpoint_vnet_policies = optional(string)
    tags                           = optional(map(string))

    encryption = optional(object({
      enforcement = string
    }))
  }))
}


variable "pips" {
  description = "Map of public IP configurations"
  type = map(object({
    # Required Arguments
    name                = string
    resource_group_name = string
    location            = string
    allocation_method   = string
    # Optional Arguments
    tags                    = optional(map(string))
    zones                   = optional(list(string))
    ddos_protection_mode    = optional(string)
    ddos_protection_plan_id = optional(string)
    domain_name_label       = optional(string)
    domain_name_label_scope = optional(string)
    edge_zone               = optional(string)
    idle_timeout_in_minutes = optional(number)
    ip_tags                 = optional(map(string))
    ip_version              = optional(string)
    public_ip_prefix_id     = optional(string)
    reverse_fqdn            = optional(string)
    sku                     = optional(string)
    sku_tier                = optional(string)
  }))
  default = {}
}


variable "nics" {
  description = "Map of Network Interfaces with configuration details."
  type = map(object({
    name                = string
    location            = string
    resource_group_name = string

    # Optional arguments
    auxiliary_mode                 = optional(string)
    auxiliary_sku                  = optional(string)
    dns_servers                    = optional(list(string))
    edge_zone                      = optional(string)
    ip_forwarding_enabled          = optional(bool)
    accelerated_networking_enabled = optional(bool)
    internal_dns_name_label        = optional(string)
    tags                           = optional(map(string))

    # IP configuration block (required)
    ip_configuration = list(object({
      name                                               = string
      private_ip_address_allocation                      = string
      gateway_load_balancer_frontend_ip_configuration_id = optional(string)
      subnet_id                                          = optional(string)
      private_ip_address_version                         = optional(string)
      public_ip_address_id                               = optional(string)
      primary                                            = optional(bool)
      private_ip_address                                 = optional(string)
    # it will define which subnet and pip to use from tfvars
      subnet_key                                         = optional(string)
      pip_key                                            = optional(string)
    }))
  }))
}


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


