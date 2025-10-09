variable "stgaccount" {
  description = "A map of storage accounts to create. The key of the map will be used as the storage account identifier."
  type = map(object({
    name                              = string
    resource_group_name               = string
    location                          = string
    account_tier                      = string
    account_replication_type          = string
    tags                              = optional(map(string), {})
    access_tier                       = optional(string, "Hot")
    provisioned_billing_model_version = optional(string)
    cross_tenant_replication_enabled  = optional(string)
    edge_zone                         = optional(string)
    https_traffic_only_enabled        = optional(string)
    min_tls_version                   = optional(string)
    shared_access_key_enabled         = optional(string)
    allow_nested_items_to_be_public   = optional(string)
    public_network_access_enabled     = optional(string)
    default_to_oauth_authentication   = optional(string)
    is_hns_enabled                    = optional(string)
    nfsv3_enabled                     = optional(string)
    large_file_share_enabled          = optional(string)
    local_user_enabled                = optional(string)
    queue_encryption_key_type         = optional(string)
    table_encryption_key_type         = optional(string)
    infrastructure_encryption_enabled = optional(string)
    dns_endpoint_type                 = optional(string)
    sftp_enabled                      = optional(string)
    allowed_copy_scope                = optional(string)

    
    # azure_files_authentication = optional(object({
    #   directory_service_options = string
    #   active_directory = object({
    #     domain_name              = optional(string)
    #     netbios_domain_name      = optional(string)
    #     forest_name              = optional(string)
    #     domain_guid              = optional(string)
    #     domain_sid               = optional(string)
    #     azure_storage_sid        = optional(string)
    #     sam_account_name         = optional(string)
    #     password                 = optional(string)
    #     organizational_unit      = optional(string)
    #     ldap_over_tls            = optional(string)
    #     primary_dns_ip_address   = optional(string)
    #     secondary_dns_ip_address = optional(string)
    #   })
    #   })
    # )

    # routing = optional(object({
    #   routing_choice              = string
    #   publish_microsoft_endpoints = bool
    #   publish_internet_endpoints  = bool
    #   publish_blob_endpoint       = bool
    #   publish_queue_endpoint      = bool
    #   publish_table_endpoint      = bool
    # }))
    # network_rules = optional(object({
    #   default_action             = string
    #   bypass                     = list(string)
    #   virtual_network_subnet_ids = list(string)
    #   ip_rules                   = list(string)
    #   trusted_services_enabled   = bool
    # }))
    # custom_domain = optional(object({
    #   name          = string
    #   use_subdomain = bool
    # }))
    # customer_managed_key = optional(object({
    #   key_vault_id = string
    #   key_name     = string
    #   key_version  = string
    # }))
    # blob_properties = optional(object({
    #   delete_retention_policy           = number
    #   versioning_enabled                = bool
    #   change_feed_enabled               = bool
    #   container_delete_retention_policy = number
    # }))
    # queue_properties = optional(object({
    #   logging = object({
    #     delete                = bool
    #     read                  = bool
    #     write                 = bool
    #     version               = string
    #     retention_policy_days = number
    #   })
    #   hour_metrics = object({
    #     enabled               = bool
    #     include_apis          = bool
    #     version               = string
    #     retention_policy_days = number
    #   })
    #   minute_metrics = object({
    #     enabled               = bool
    #     include_apis          = bool
    #     version               = string
    #     retention_policy_days = number
    #   })
    # }))

    # identity = optional(object({
    #   type         = string
    #   identity_ids = list(string)
    # }))

    # encryption = optional(object({
    #   key_source = string
    #   services = object({
    #     blob = object({
    #       enabled  = bool
    #       key_type = string
    #     })
    #     file = object({
    #       enabled  = bool
    #       key_type = string
    #     })
    #     queue = object({
    #       enabled  = bool
    #       key_type = string
    #     })
    #     table = object({
    #       enabled  = bool
    #       key_type = string
    #     })
    #   })
    # }))

    # file_properties = optional(object({
    #   share_delete_retention_policy = number
    #   smb = object({
    #     authentication_methods         = list(string)
    #     channel_encryption_type        = string
    #     kerberos_ticket_encryption     = string
    #     multichannel_enabled           = bool
    #     oplocks_enabled                = bool
    #     share_access_based_enumeration = bool
    #     versions                       = list(string)
    #   })
    # }))

    # static_website = optional(object({
    #   index_document     = string
    #   error_404_document = string
    #   enabled            = bool
    # }))

    # share_properties = optional(object({
    #   quota = number
    # }))

    # sas_policy = optional(object({
    #   sas_policy_name = string
    #   permissions     = string
    #   services        = string
    #   resource_types  = string
    #   start           = string
    #   expiry          = string
    #   https_only      = bool
    #   ip_ranges       = list(string)
    # }))

    # immutability_policy = optional(object({
    #   state                         = string
    #   allow_protected_append_writes = bool
    #   period_in_days                = number
    # }))

  }))
}
