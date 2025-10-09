resource "azurerm_storage_account" "stg" {
  for_each = var.stgaccount

  name                              = each.value.name
  resource_group_name               = each.value.resource_group_name
  location                          = each.value.location
  account_tier                      = each.value.account_tier
  account_replication_type          = each.value.account_replication_type
  access_tier                       = each.value.access_tier
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


# routing {
#   routing_choice           = each.value.routing.routing_choice
#   publish_microsoft_endpoints = each.value.routing.publish_microsoft_endpoints
#   publish_internet_endpoints   = each.value.routing.publish_internet_endpoints
#   publish_blob_endpoint        = each.value.routing.publish_blob_endpoint
#   publish_queue_endpoint       = each.value.routing.publish_queue_endpoint
#   publish_table_endpoint       = each.value.routing.publish_table_endpoint
# }


}
# azure_files_authentication {
#   directory_service_options = each.value.azure_files_authentication.directory_service_options
#   active_directory {
#     directory_type          = each.value.azure_files_authentication.active_directory.directory_type
#     domain_name               = each.value.azure_files_authentication.active_directory.domain_name
#     netbios_domain_name       = each.value.azure_files_authentication.active_directory.netbios_domain_name
#     forest_name               = each.value.azure_files_authentication.active_directory.forest_name
#     domain_guid               = each.value.azure_files_authentication.active_directory.domain_guid
#     domain_sid                = each.value.azure_files_authentication.active_directory.domain_sid
#     azure_storage_sid         = each.value.azure_files_authentication.active_directory.azure_storage_sid
#     sam_account_name          = each.value.azure_files_authentication.active_directory.sam_account_name
#     password                  = each.value.azure_files_authentication.active_directory.password
#     organizational_unit       = each.value.azure_files_authentication.active_directory.organizational_unit
#     ldap_over_tls             = each.value.azure_files_authentication.active_directory.ldap_over_tls
#     primary_dns_ip_address    = each.value.azure_files_authentication.active_directory.primary_dns_ip_address
#     secondary_dns_ip_address  = each.value.azure_files_authentication.active_directory.secondary_dns_ip_address
#   }
# }

# network_rules {
#   default_action             = each.value.network_rules.default_action
#   bypass                     = each.value.network_rules.bypass
#   virtual_network_subnet_ids = each.value.network_rules.virtual_network_subnet_ids
#   ip_rules                   = each.value.network_rules.ip_rules
#   trusted_services_enabled   = each.value.network_rules.trusted_services_enabled
# }
# custom_domain  {
#   name          = each.value.custom_domain.name
#   use_subdomain = each.value.custom_domain.use_subdomain
# }
# customer_managed_key {
#   key_vault_id            = each.value.customer_managed_key.key_vault_id
#   key_name                = each.value.customer_managed_key.key_name
#   key_version             = each.value.customer_managed_key
# }
# blob_properties {
#   delete_retention_policy = each.value.blob_properties.delete_retention_policy
#   versioning_enabled      = each.value.blob_properties.versioning_enabled
#   change_feed_enabled     = each.value.blob_properties.change_feed_enabled
#   container_delete_retention_policy = each.value.blob_properties.container_delete_retention_policy
# }

# queue_properties {
#   logging {
#     delete                = each.value.queue_properties.logging.delete
#     read                  = each.value.queue_properties.logging.read
#     write                 = each.value.queue_properties.logging.write
#     version               = each.value.queue_properties.logging.version
#     retention_policy_days = each.value.queue_properties.logging.retention_policy_days
#   }
#   hour_metrics {
#     enabled               = each.value.queue_properties.hour_metrics.enabled
#     include_apis          = each.value.queue_properties.hour_metrics.include_apis
#     version               = each.value.queue_properties.hour_metrics.version
#     retention_policy_days = each.value.queue_properties.hour_metrics.retention_policy_days
#   }
#   minute_metrics {
#     enabled               = each.value.queue_properties.minute_metrics.enabled
#     include_apis          = each.value.queue_properties.minute_metrics.include_apis
#     version               = each.value.queue_properties.minute_metrics.version
#     retention_policy_days = each.value.queue_properties.minute_metrics.retention_policy_days
#   }
# }
# identity{
#   type         = each.value.identity.type
#   identity_ids = each.value.identity.identity_ids
# }
# encryption{
#   services {
#     blob {
#       enabled           = each.value.encryption.services.blob.enabled
#       key_type         = each.value.encryption.services.blob.key_type
#     }
#     file {
#       enabled           = each.value.encryption.services.file.enabled
#       key_type         = each.value.encryption.services.file.key_type
#     }
#     queue {
#       enabled           = each.value.encryption.services.queue.enabled
#       key_type         = each.value.encryption.services.queue.key_type
#     }
#     table {
#       enabled           = each.value.encryption.services.table.enabled
#       key_type         = each.value.encryption.services.table.key_type
#     }
#   }
#   key_source = each.value.encryption.key_source
# }
# file_properties {
#   share_delete_retention_policy = each.value.file_properties.share_delete_retention_policy
#   smb {
#     authentication_methods        = each.value.file_properties.smb.authentication_methods
#     channel_encryption_type       = each.value.file_properties.smb.channel_encryption_type
#     kerberos_ticket_encryption    = each.value.file_properties.smb.kerberos_ticket_encryption
#     multichannel_enabled          = each.value.file_properties.smb.multichannel_enabled
#     oplocks_enabled               = each.value.file_properties.smb.oplocks_enabled
#     share_access_based_enumeration = each.value.file_properties.smb.share_access_based_enumeration
#     versions                     = each.value.file_properties.smb.versions
#   }
# }
# static_website {
#   index_document = each.value.static_website.index_document
#   error_404_document = each.value.static_website.error_404_document
#   enabled         = each.value.static_website.enabled
# }
# share_properties  {
#   quota = each.value.share_properties.quota
# }
# sas_policy  {
#   sas_policy_name           = each.value.sas_policy.sas_policy_name
#   permissions               = each.value.sas_policy.permissions
#   services                  = each.value.sas_policy.services
#   resource_types            = each.value.sas_policy.resource_types
#   start                     = each.value.sas_policy.start
#   expiry                    = each.value.sas_policy.expiry
#   https_only                = each.value.sas_policy.https_only
#   ip_ranges                 = each.value.sas_policy.ip_ranges
# }
# immutability_policy{
#   state                      = each.value.immutability_policy.state
#   allow_protected_append_writes = each.value.immutability_policy.allow_protected_append_writes
#   period_in_days             = each.value.immutability_policy.period_in_days
# }





# }

# azure_files_authentication {
#   directory_service_options = each.value.azure_files_authentication.directory_service_options
#   active_directory {
#     domain_name               = each.value.azure_files_authentication.active_directory.domain_name
#     netbios_domain_name       = each.value.azure_files_authentication.active_directory.netbios_domain_name
#     forest_name               = each.value.azure_files_authentication.active_directory.forest_name
#     domain_guid               = each.value.azure_files_authentication.active_directory.domain_guid
#     domain_sid                = each.value.azure_files_authentication.active_directory.domain_sid
#     azure_storage_sid         = each.value.azure_files_authentication.active_directory.azure_storage_sid
#     sam_account_name          = each.value.azure_files_authentication.active_directory.sam_account_name
#     password                  = each.value.azure_files_authentication.active_directory.password
#     organizational_unit       = each.value.azure_files_authentication.active_directory.organizational_unit
#     ldap_over_tls             = each.value.azure_files_authentication.active_directory.ldap_over_tls
#     primary_dns_ip_address    = each.value.azure_files_authentication.active_directory.primary_dns_ip_address
#     secondary_dns_ip_address  = each.value.azure_files_authentication.active_directory.secondary_dns_ip_address
#   }
# }
# routing {
#   routing_choice           = each.value.routing.routing_choice
#   publish_microsoft_endpoints = each.value.routing.publish_microsoft_endpoints
#   publish_internet_endpoints   = each.value.routing.publish_internet_endpoints
#   publish_blob_endpoint        = each.value.routing.publish_blob_endpoint
#   publish_queue_endpoint       = each.value.routing.publish_queue_endpoint
#   publish_table_endpoint       = each.value.routing.publish_table_endpoint
# }
# network_rules {
#   default_action             = each.value.network_rules.default_action
#   bypass                     = each.value.network_rules.bypass
#   virtual_network_subnet_ids = each.value.network_rules.virtual_network_subnet_ids
#   ip_rules                   = each.value.network_rules.ip_rules
#   trusted_services_enabled   = each.value.network_rules.trusted_services_enabled
# }
# custom_domain  {
#   name          = each.value.custom_domain.name
#   use_subdomain = each.value.custom_domain.use_subdomain
# }
# customer_managed_key {
#   key_vault_id            = each.value.customer_managed_key.key_vault_id
#   key_name                = each.value.customer_managed_key.key_name
#   key_version             = each.value.customer_managed_key
# }
# blob_properties {
#   delete_retention_policy = each.value.blob_properties.delete_retention_policy
#   versioning_enabled      = each.value.blob_properties.versioning_enabled
#   change_feed_enabled     = each.value.blob_properties.change_feed_enabled
#   container_delete_retention_policy = each.value.blob_properties.container_delete_retention_policy
# }

# queue_properties {
#   logging {
#     delete                = each.value.queue_properties.logging.delete
#     read                  = each.value.queue_properties.logging.read
#     write                 = each.value.queue_properties.logging.write
#     version               = each.value.queue_properties.logging.version
#     retention_policy_days = each.value.queue_properties.logging.retention_policy_days
#   }
#   hour_metrics {
#     enabled               = each.value.queue_properties.hour_metrics.enabled
#     include_apis          = each.value.queue_properties.hour_metrics.include_apis
#     version               = each.value.queue_properties.hour_metrics.version
#     retention_policy_days = each.value.queue_properties.hour_metrics.retention_policy_days
#   }
#   minute_metrics {
#     enabled               = each.value.queue_properties.minute_metrics.enabled
#     include_apis          = each.value.queue_properties.minute_metrics.include_apis
#     version               = each.value.queue_properties.minute_metrics.version
#     retention_policy_days = each.value.queue_properties.minute_metrics.retention_policy_days
#   }
# }
# identity{
#   type         = each.value.identity.type
#   identity_ids = each.value.identity.identity_ids
# }
# encryption{
#   services {
#     blob {
#       enabled           = each.value.encryption.services.blob.enabled
#       key_type         = each.value.encryption.services.blob.key_type
#     }
#     file {
#       enabled           = each.value.encryption.services.file.enabled
#       key_type         = each.value.encryption.services.file.key_type
#     }
#     queue {
#       enabled           = each.value.encryption.services.queue.enabled
#       key_type         = each.value.encryption.services.queue.key_type
#     }
#     table {
#       enabled           = each.value.encryption.services.table.enabled
#       key_type         = each.value.encryption.services.table.key_type
#     }
#   }
#   key_source = each.value.encryption.key_source
# }
# file_properties {
#   share_delete_retention_policy = each.value.file_properties.share_delete_retention_policy
#   smb {
#     authentication_methods        = each.value.file_properties.smb.authentication_methods
#     channel_encryption_type       = each.value.file_properties.smb.channel_encryption_type
#     kerberos_ticket_encryption    = each.value.file_properties.smb.kerberos_ticket_encryption
#     multichannel_enabled          = each.value.file_properties.smb.multichannel_enabled
#     oplocks_enabled               = each.value.file_properties.smb.oplocks_enabled
#     share_access_based_enumeration = each.value.file_properties.smb.share_access_based_enumeration
#     versions                     = each.value.file_properties.smb.versions
#   }
# }
# static_website {
#   index_document = each.value.static_website.index_document
#   error_404_document = each.value.static_website.error_404_document
#   enabled         = each.value.static_website.enabled
# }
# share_properties  {
#   quota = each.value.share_properties.quota
# }
# sas_policy  {
#   sas_policy_name           = each.value.sas_policy.sas_policy_name
#   permissions               = each.value.sas_policy.permissions
#   services                  = each.value.sas_policy.services
#   resource_types            = each.value.sas_policy.resource_types
#   start                     = each.value.sas_policy.start
#   expiry                    = each.value.sas_policy.expiry
#   https_only                = each.value.sas_policy.https_only
#   ip_ranges                 = each.value.sas_policy.ip_ranges
# }
# immutability_policy{
#   state                      = each.value.immutability_policy.state
#   allow_protected_append_writes = each.value.immutability_policy.allow_protected_append_writes
#   period_in_days             = each.value.immutability_policy.period_in_days
# }