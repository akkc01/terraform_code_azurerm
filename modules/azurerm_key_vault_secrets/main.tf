
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
  numeric = true

}
resource "random_string" "username2" {
  length = 12
  upper  = true
  lower  = true
  numeric = true
}
resource "azurerm_key_vault_secret" "username_secrets1" {
  name         = var.vm1user
  value        = random_string.username1.result
  key_vault_id = data.azurerm_key_vault.kv.id
}
resource "azurerm_key_vault_secret" "username_secrets2" {
  name         = var.vm2user
  value        = random_string.username2.result
  key_vault_id = data.azurerm_key_vault.kv.id
}
resource "azurerm_key_vault_secret" "password_secrets1" {
  name         = var.vm1pass
  value        = random_password.vm_passwords1.result
  key_vault_id = data.azurerm_key_vault.kv.id
}
resource "azurerm_key_vault_secret" "password_secrets2" {
  name         = var.vm2pass
  value        = random_password.vm_passwords2.result
  key_vault_id = data.azurerm_key_vault.kv.id
}
