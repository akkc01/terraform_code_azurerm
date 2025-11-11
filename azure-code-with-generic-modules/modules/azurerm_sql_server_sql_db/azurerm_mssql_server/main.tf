resource "azurerm_mssql_server" "sqlserver" {
  for_each = var.sql_servers

  name                         = each.value.name
  resource_group_name          = var.rg_name[each.value.rg_key]
  location                     = each.value.location
  version                      = each.value.version
  administrator_login          = data.azurerm_key_vault_secret.sql_user[each.key].value
  administrator_login_password = data.azurerm_key_vault_secret.sql_pass[each.key].value
  connection_policy            = lookup(each.value, "connection_policy", "Default")

  # Optional: Managed Identity
  dynamic "identity" {
    for_each = each.value.identity != null ? [each.value.identity] : []
    content {
      type = identity.value.type
    }
  }

  # Optional: Threat Detection Policy
  dynamic "threat_detection_policy" {
    for_each = each.value.threat_detection_policy != null ? [each.value.threat_detection_policy] : []
    content {
      state                      = threat_detection_policy.value.state
      disabled_alerts            = lookup(threat_detection_policy.value, "disabled_alerts", null)
      email_account_admins       = lookup(threat_detection_policy.value, "email_account_admins", false)
      email_addresses            = lookup(threat_detection_policy.value, "email_addresses", null)
      retention_days             = lookup(threat_detection_policy.value, "retention_days", null)
      storage_account_access_key = lookup(threat_detection_policy.value, "storage_account_access_key", null)
      storage_endpoint           = lookup(threat_detection_policy.value, "storage_endpoint", null)
    }
  }

  tags = lookup(each.value, "tags", null)
}
