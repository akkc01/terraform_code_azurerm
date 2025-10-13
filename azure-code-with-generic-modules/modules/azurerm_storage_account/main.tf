resource "azurerm_storage_account" "stg" {
  for_each = var.stgaccount

 # Required Arguments
  name                              = each.value.name
  resource_group_name               = each.value.resource_group_name
  location                          = each.value.location
  account_tier                      = each.value.account_tier
  account_replication_type          = each.value.account_replication_type
   
# Optional Arguments
  account_kind                      = each.value.account_kind
  tags                              = each.value.tags
  provisioned_billing_model_version = each.value.provisioned_billing_model_version
  cross_tenant_replication_enabled  = each.value.cross_tenant_replication_enabled
  edge_zone                         = each.value.edge_zone
  https_traffic_only_enabled        = each.value.https_traffic_only_enabled
  min_tls_version                   = each.value.min_tls_version
  shared_access_key_enabled         = each.value.shared_access_key_enabled
  allow_nested_items_to_be_public   = each.value.allow_nested_items_to_be_public
  public_network_access_enabled     = each.value.public_network_access_enabled
  default_to_oauth_authentication   = each.value.default_to_oauth_authentication
  is_hns_enabled                    = each.value.is_hns_enabled
  nfsv3_enabled                     = each.value.nfsv3_enabled
  large_file_share_enabled          = each.value.large_file_share_enabled
  local_user_enabled                = each.value.local_user_enabled
  queue_encryption_key_type         = each.value.queue_encryption_key_type
  table_encryption_key_type         = each.value.table_encryption_key_type
  infrastructure_encryption_enabled = each.value.infrastructure_encryption_enabled
  dns_endpoint_type                 = each.value.dns_endpoint_type
  sftp_enabled                      = each.value.sftp_enabled
  allowed_copy_scope                = each.value.allowed_copy_scope


# Block Arguments (Optional Arguments)

  # Yeh (custom_domain) tab kaam karega without dynamic block, -
        # -only jab hum custom_domain me sabhi arguments ki value ko tfvars me paas karnege.
  # ✅ Hamesha present hai(matalab ki iska use karunga tab mujhe iski value tfvars me dena hoga)
  # ✅ Agar aap custom_domain ki values provide nahi karte:
           # - Toh Terraform plan/run fail karega with an error like:
           #     - Error: Unsupported attribute
           #     - This object does not have an attribute named "custom_domain".
  # ✅ Aur yeh block resource/module ke syntax ke according valid hai.(jab values paas kareng tab kaam karega)

  # custom_domain {
  #   name          = each.value.custom_domain.name
  #   use_subdomain = each.value.custom_domain.use_subdomain
  # }

  dynamic "custom_domain" {
    for_each = each.value.custom_domain != null ? [each.value.custom_domain] : []
    content {
      name          = custom_domain.value.name
      use_subdomain = try(custom_domain.value.use_subdomain, null)
    }
  }

  # customer_managed_key {
  #   user_assigned_identity_id = each.value.customer_managed_key.user_assigned_identity_id
  #   key_vault_key_id          = each.value.customer_managed_key.key_vault_key_id
  #   managed_hsm_key_id        = each.value.customer_managed_key.managed_hsm_key_id
  # }

  dynamic "customer_managed_key" {
    for_each = each.value.customer_managed_key != null ? [each.value.customer_managed_key] : []
    content {
      user_assigned_identity_id = try(customer_managed_key.value.user_assigned_identity_id, null)
      key_vault_key_id          = try(customer_managed_key.value.key_vault_key_id, null)
      managed_hsm_key_id        = try(customer_managed_key.value.managed_hsm_key_id, null)
    }
  }

  # identity {
  #   type         = each.value.identity.type
  #   identity_ids = each.value.identity.identity_ids
  # }

  dynamic "identity" {
    for_each = each.value.identity != null ? [each.value.identity] : []
    content {
      type         = try(identity.value.type, null)
      identity_ids = try(identity.value.identity_ids, null)
    }
  }

  # blob_properties {
  #   cors_rule {
  #     allowed_headers    = each.value.blob_properties.cors_rule[*].allowed_headers
  #     allowed_methods    = each.value.blob_properties.cors_rule[*].allowed_methods
  #     allowed_origins    = each.value.blob_properties.cors_rule[*].allowed_origins
  #     exposed_headers    = each.value.blob_properties.cors_rule[*].exposed_headers
  #     max_age_in_seconds = each.value.blob_properties.cors_rule[*].max_age_in_seconds
  #   }
  #   delete_retention_policy {
  #     days = each.value.blob_properties.delete_retention_policy.days
  #   }
  #   restore_policy {
  #     days = each.value.blob_properties.restore_policy.days
  #   }
  #   versioning_enabled            = each.value.blob_properties.versioning_enabled
  #   change_feed_enabled           = each.value.blob_properties.change_feed_enabled
  #   change_feed_retention_in_days = each.value.blob_properties.change_feed_retention_in_days
  #   default_service_version       = each.value.blob_properties.default_service_version
  #   last_access_time_enabled      = each.value.blob_properties.last_access_time_enabled
  #   container_delete_retention_policy {
  #     days = each.value.blob_properties.container_delete_retention_policy.days
  #   }
  # }

  dynamic "blob_properties" {
    for_each = each.value.blob_properties != null ? [each.value.blob_properties] : []
    content {
      dynamic "cors_rule" {
        for_each = try(blob_properties.value.cors_rule, [])
        content {
          allowed_headers    = try(cors_rule.value.allowed_headers, null)
          allowed_methods    = try(cors_rule.value.allowed_methods, null)
          allowed_origins    = try(cors_rule.value.allowed_origins, null)
          exposed_headers    = try(cors_rule.value.exposed_headers, null)
          max_age_in_seconds = try(cors_rule.value.max_age_in_seconds, null)
        }
      }

      dynamic "delete_retention_policy" {
        for_each = try(blob_properties.value.delete_retention_policy, null) != null ? [blob_properties.value.delete_retention_policy] : []
        content {
          days = try(delete_retention_policy.value.days, null)
        }
      }

      dynamic "restore_policy" {
        for_each = try(blob_properties.value.restore_policy, null) != null ? [blob_properties.value.restore_policy] : []
        content {
          days = try(restore_policy.value.days, null)
        }
      }

      versioning_enabled            = try(blob_properties.value.versioning_enabled, null)
      change_feed_enabled           = try(blob_properties.value.change_feed_enabled, null)
      change_feed_retention_in_days = try(blob_properties.value.change_feed_retention_in_days, null)
      default_service_version       = try(blob_properties.value.default_service_version, null)
      last_access_time_enabled      = try(blob_properties.value.last_access_time_enabled, null)

      dynamic "container_delete_retention_policy" {
        for_each = try(blob_properties.value.container_delete_retention_policy, null) != null ? [blob_properties.value.container_delete_retention_policy] : []
        content {
          days = try(container_delete_retention_policy.value.days, null)
        }
      }
    }
  }


  # queue_properties {
  #   cors_rule {
  #     allowed_headers    = each.value.queue_properties.cors_rule[*].allowed_headers
  #     allowed_methods    = each.value.queue_properties.cors_rule[*].allowed_methods
  #     allowed_origins    = each.value.queue_properties.cors_rule[*].allowed_origins
  #     exposed_headers    = each.value.queue_properties.cors_rule[*].exposed_headers
  #     max_age_in_seconds = each.value.queue_properties.cors_rule[*].max_age_in_seconds
  #   }
  #   logging {
  #     delete                = each.value.queue_properties.logging.delete
  #     read                  = each.value.queue_properties.logging.read
  #     write                 = each.value.queue_properties.logging.write
  #     version               = each.value.queue_properties.logging.version
  #     retention_policy_days = each.value.queue_properties.logging.retention_policy_days
  #   }
  #   hour_metrics {
  #     enabled               = each.value.queue_properties.hour_metrics.enabled
  #     version               = each.value.queue_properties.hour_metrics.version
  #     include_apis          = each.value.queue_properties.hour_metrics.include_apis
  #     retention_policy_days = each.value.queue_properties.hour_metrics.retention_policy_days
  #   }
  #   minute_metrics {
  #     enabled               = each.value.queue_properties.minute_metrics.enabled
  #     version               = each.value.queue_properties.minute_metrics.version
  #     include_apis          = each.value.queue_properties.minute_metrics.include_apis
  #     retention_policy_days = each.value.queue_properties.minute_metrics.retention_policy_days
  #   }
  # }

  dynamic "queue_properties" {
    for_each = each.value.queue_properties != null ? [each.value.queue_properties] : []
    content {

      dynamic "cors_rule" {
        for_each = try(queue_properties.value.cors_rule, [])
        content {
          allowed_headers    = try(cors_rule.value.allowed_headers, null)
          allowed_methods    = try(cors_rule.value.allowed_methods, null)
          allowed_origins    = try(cors_rule.value.allowed_origins, null)
          exposed_headers    = try(cors_rule.value.exposed_headers, null)
          max_age_in_seconds = try(cors_rule.value.max_age_in_seconds, null)
        }
      }

      dynamic "logging" {
        for_each = try(queue_properties.value.logging, null) != null ? [queue_properties.value.logging] : []
        content {
          delete                = try(logging.value.delete, null)
          read                  = try(logging.value.read, null)
          write                 = try(logging.value.write, null)
          version               = try(logging.value.version, null)
          retention_policy_days = try(logging.value.retention_policy_days, null)
        }
      }

      dynamic "hour_metrics" {
        for_each = try(queue_properties.value.hour_metrics, null) != null ? [queue_properties.value.hour_metrics] : []
        content {
          enabled               = try(hour_metrics.value.enabled, null)
          version               = try(hour_metrics.value.version, null)
          include_apis          = try(hour_metrics.value.include_apis, null)
          retention_policy_days = try(hour_metrics.value.retention_policy_days, null)
        }
      }

      dynamic "minute_metrics" {
        for_each = try(queue_properties.value.minute_metrics, null) != null ? [queue_properties.value.minute_metrics] : []
        content {
          enabled               = try(minute_metrics.value.enabled, null)
          version               = try(minute_metrics.value.version, null)
          include_apis          = try(minute_metrics.value.include_apis, null)
          retention_policy_days = try(minute_metrics.value.retention_policy_days, null)
        }
      }

    }
  }

  # static_website {
  #   index_document     = each.value.static_website.index_document
  #   error_404_document = each.value.static_website.error_404_document
  # }

  dynamic "static_website" {
    for_each = each.value.static_website != null ? [each.value.static_website] : []
    content {
      index_document     = try(static_website.value.index_document, null)
      error_404_document = try(static_website.value.error_404_document, null)
    }
  }


  # share_properties {
  #   cors_rule {
  #     allowed_headers    = each.value.share_properties.cors_rule[*].allowed_headers
  #     allowed_methods    = each.value.share_properties.cors_rule[*].allowed_methods
  #     allowed_origins    = each.value.share_properties.cors_rule[*].allowed_origins
  #     exposed_headers    = each.value.share_properties.cors_rule[*].exposed_headers
  #     max_age_in_seconds = each.value.share_properties.cors_rule[*].max_age_in_seconds
  #   }
  #   retention_policy {
  #     days = each.value.share_properties.retention_policy.days
  #   }
  #   smb {
  #     versions                        = each.value.share_properties.smb.versions
  #     authentication_types            = each.value.share_properties.smb.authentication_types
  #     kerberos_ticket_encryption_type = each.value.share_properties.smb.kerberos_ticket_encryption_type
  #     channel_encryption_type         = each.value.share_properties.smb.channel_encryption_type
  #     multichannel_enabled            = each.value.share_properties.smb.multichannel_enabled
  #   }
  # }

  dynamic "share_properties" {
    for_each = each.value.share_properties != null ? [each.value.share_properties] : []
    content {

      dynamic "cors_rule" {
        for_each = try(share_properties.value.cors_rule, [])
        content {
          allowed_headers    = try(cors_rule.value.allowed_headers, null)
          allowed_methods    = try(cors_rule.value.allowed_methods, null)
          allowed_origins    = try(cors_rule.value.allowed_origins, null)
          exposed_headers    = try(cors_rule.value.exposed_headers, null)
          max_age_in_seconds = try(cors_rule.value.max_age_in_seconds, null)
        }
      }

      dynamic "retention_policy" {
        for_each = try(share_properties.value.retention_policy, null) != null ? [share_properties.value.retention_policy] : []
        content {
          days = try(retention_policy.value.days, null)
        }
      }

      dynamic "smb" {
        for_each = try(share_properties.value.smb, null) != null ? [share_properties.value.smb] : []
        content {
          versions                        = try(smb.value.versions, null)
          authentication_types            = try(smb.value.authentication_types, null)
          kerberos_ticket_encryption_type = try(smb.value.kerberos_ticket_encryption_type, null)
          channel_encryption_type         = try(smb.value.channel_encryption_type, null)
          multichannel_enabled            = try(smb.value.multichannel_enabled, null)
        }
      }

    }
  }

  # network_rules {
  #   default_action             = each.value.network_rules.default_action
  #   bypass                     = each.value.network_rules.bypass
  #   virtual_network_subnet_ids = each.value.network_rules.virtual_network_subnet_ids
  #   ip_rules                   = each.value.network_rules.ip_rules
  #   private_link_access {
  #     endpoint_resource_id = each.value.network_rules.private_link_access.endpoint_resource_id
  #     endpoint_tenant_id   = each.value.network_rules.private_link_access.endpoint_tenant_id
  #   }
  # }

  dynamic "network_rules" {
    for_each = each.value.network_rules != null ? [each.value.network_rules] : []
    content {
      default_action             = try(network_rules.value.default_action, null)
      bypass                     = try(network_rules.value.bypass, null)
      virtual_network_subnet_ids = try(network_rules.value.virtual_network_subnet_ids, null)
      ip_rules                   = try(network_rules.value.ip_rules, null)

      dynamic "private_link_access" {
        for_each = try(network_rules.value.private_link_access, null) != null ? [network_rules.value.private_link_access] : []
        content {
          endpoint_resource_id = try(private_link_access.value.endpoint_resource_id, null)
          endpoint_tenant_id   = try(private_link_access.value.endpoint_tenant_id, null)
        }
      }
    }
  }

  # azure_files_authentication {
  #   directory_type                 = each.value.azure_files_authentication.directory_type
  #   default_share_level_permission = each.value.azure_files_authentication.default_share_level_permission
  #   active_directory {
  #     domain_name         = each.value.azure_files_authentication.active_directory.domain_name
  #     netbios_domain_name = each.value.azure_files_authentication.active_directory.netbios_domain_name
  #     forest_name         = each.value.azure_files_authentication.active_directory.forest_name
  #     domain_guid         = each.value.azure_files_authentication.active_directory.domain_guid
  #     domain_sid          = each.value.azure_files_authentication.active_directory.domain_sid
  #     storage_sid         = each.value.azure_files_authentication.active_directory.storage_sid
  #   }

  # }

  dynamic "azure_files_authentication" {
    for_each = each.value.azure_files_authentication != null ? [each.value.azure_files_authentication] : []
    content {
      directory_type                 = try(azure_files_authentication.value.directory_type, null)
      default_share_level_permission = try(azure_files_authentication.value.default_share_level_permission, null)

      dynamic "active_directory" {
        for_each = try(azure_files_authentication.value.active_directory, null) != null ? [azure_files_authentication.value.active_directory] : []
        content {
          domain_name         = try(active_directory.value.domain_name, null)
          netbios_domain_name = try(active_directory.value.netbios_domain_name, null)
          forest_name         = try(active_directory.value.forest_name, null)
          domain_guid         = try(active_directory.value.domain_guid, null)
          domain_sid          = try(active_directory.value.domain_sid, null)
          storage_sid         = try(active_directory.value.storage_sid, null)
        }
      }
    }
  }

  # routing {
  #   choice                      = each.value.routing.choice
  #   publish_microsoft_endpoints = each.value.routing.publish_microsoft_endpoints
  #   publish_internet_endpoints  = each.value.routing.publish_internet_endpoints
  # }

  dynamic "routing" {
    for_each = each.value.routing != null ? [each.value.routing] : []
    content {
      choice                      = try(routing.value.choice, null)
      publish_microsoft_endpoints = try(routing.value.publish_microsoft_endpoints, null)
      publish_internet_endpoints  = try(routing.value.publish_internet_endpoints, null)
    }
  }


  # immutability_policy {
  #   state                         = each.value.immutability_policy.state
  #   allow_protected_append_writes = each.value.immutability_policy.allow_protected_append_writes
  #   period_since_creation_in_days = each.value.immutability_policy.period_since_creation_in_days
  # }

  dynamic "immutability_policy" {
    for_each = each.value.immutability_policy != null ? [each.value.immutability_policy] : []
    content {
      state                         = try(immutability_policy.value.state, null)
      allow_protected_append_writes = try(immutability_policy.value.allow_protected_append_writes, null)
      period_since_creation_in_days = try(immutability_policy.value.period_since_creation_in_days, null)
    }
  }


  # sas_policy {
  #   expiration_action = each.value.sas_policy.expiration_action
  #   expiration_period = each.value.sas_policy.expiration_period
  # }

dynamic "sas_policy" {
  for_each = each.value.sas_policy != null ? [each.value.sas_policy] : []
  content {
    expiration_action = try(sas_policy.value.expiration_action, null)
    expiration_period = try(sas_policy.value.expiration_period, null)
  }
}





}
  