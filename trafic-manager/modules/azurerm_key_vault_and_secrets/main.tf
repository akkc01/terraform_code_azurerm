data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "kv" {
  name                        = var.kv_name
  location                    = var.location
  resource_group_name         = var.rg_name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  # soft_delete_retention_days  = 7
  purge_protection_enabled = false
  sku_name = "standard"
  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    secret_permissions = [
      "Set",
      "Get",
      "List",
      "Delete",
      "Backup",
      "Restore",
      "Recover",
      "Purge"
    ]

    storage_permissions = [
      "Get",
    ]
  }
}


resource "random_password" "vm_passwords" {
  for_each = var.vm_secrets

  length           = 16
  min_upper        = 2
  min_lower        = 2
  min_numeric      = 2
  min_special      = 2
  override_special = "!@#$%&*()-_=+" # Azure-friendly special characters
}

resource "random_string" "vm_usernames" {
  for_each = var.vm_secrets

  length  = 12
  upper   = true
  lower   = true
  numeric = true
}

resource "azurerm_key_vault_secret" "usernames" {
  for_each = var.vm_secrets

  name         = each.value.secret_name
  value        = random_string.vm_usernames[each.key].result
  key_vault_id = azurerm_key_vault.kv.id
}

resource "azurerm_key_vault_secret" "passwords" {
  for_each = var.vm_secrets

  name         = each.value.secret_pass
  value        = random_password.vm_passwords[each.key].result
  key_vault_id = azurerm_key_vault.kv.id
}

