data "azurerm_network_interface" "vmnic" {
  name                = var.vm_nic_name
  resource_group_name = var.rg_name
}

data "azurerm_key_vault" "kv" {
  name                = var.kv_name
  resource_group_name = var.rg_name
}

data "azurerm_key_vault_secret" "vm_username1" {
  name         = var.vmuser
  key_vault_id = data.azurerm_key_vault.kv.id
}

data "azurerm_key_vault_secret" "vm_password1" {
  name         = var.vmpass
  key_vault_id = data.azurerm_key_vault.kv.id
}

