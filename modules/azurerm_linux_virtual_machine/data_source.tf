data "azurerm_network_interface" "vmnic" {
  name                = var.vm_nic_name
  resource_group_name = var.rg_name
}

data "azurerm_key_vault" "kv" {
  name                = var.kv_name
  resource_group_name = var.rg_name
}

data "azurerm_key_vault_secret" "vm_username1" {
  name         = "vm1-admin-username"
  key_vault_id = data.azurerm_key_vault.kv.id
}

data "azurerm_key_vault_secret" "vm_password1" {
  name         = "vm1-admin-secret"
  key_vault_id = data.azurerm_key_vault.kv.id
}

data "azurerm_key_vault_secret" "vm_username2" {
  name         = "vm2-admin-username"
  key_vault_id = data.azurerm_key_vault.kv.id
}

data "azurerm_key_vault_secret" "vm_password2" {
  name         = "vm2-admin-secret"
  key_vault_id = data.azurerm_key_vault.kv.id
}
