data "azurerm_key_vault_secret" "sql_user" {
  name         = var.sql-user
  key_vault_id = data.azurerm_key_vault.kv.id
}

data "azurerm_key_vault_secret" "sql_pass" {
  name         = var.sql-pass
  key_vault_id = data.azurerm_key_vault.kv.id
}
