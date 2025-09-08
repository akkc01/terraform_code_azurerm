
data "azurerm_client_config" "current" {}

resource "random_password" "vm_passwords1" {
  length  = 16
  special = true
}

resource "random_password" "vm_passwords2" {
  length  = 16
  special = true
}

resource "random_string" "username1" {
  length = 12
  upper  = true
  lower  = true
  number = true

}
resource "random_string" "username2" {
  length = 12
  upper  = true
  lower  = true
  number = true
}
resource "azurerm_key_vault_secret" "username_secrets" {
  name         = "vm1-admin-username"
  value        = random_string.username1.result
  key_vault_id = data.azurerm_key_vault.kv.id
}
resource "azurerm_key_vault_secret" "username_secrets" {
  name         = "vm2-admin-username"
  value        = random_string.username2.result
  key_vault_id = data.azurerm_key_vault.kv.id
}
resource "azurerm_key_vault_secret" "password_secrets" {
  name         = "vm1-admin-secret"
  value        = random_password.vm_passwords1.result
  key_vault_id = data.azurerm_key_vault.kv.id
}
resource "azurerm_key_vault_secret" "password_secrets" {
  name         = "vm2-admin-secret"
  value        = random_password.vm_passwords2.result
  key_vault_id = data.azurerm_key_vault.kv.id
}
