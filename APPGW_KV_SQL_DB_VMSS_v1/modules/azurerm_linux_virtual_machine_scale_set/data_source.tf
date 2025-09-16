data "azurerm_subnet" "vmss_sub" {
  name                 = var.vmss_sub
  virtual_network_name = var.vnet_name
  resource_group_name  = var.rg_name
}

data "azurerm_network_security_group" "nsg1" {
  name                = var.nsg_name
  resource_group_name = var.rg_name
}

data "azurerm_application_gateway" "appgw" {
  name                = var.appgw_name
  resource_group_name = var.rg_name
}

data "azurerm_key_vault" "kv" {
  name                = var.kv_name
  resource_group_name = var.rg_name
}

data "azurerm_key_vault_secret" "vm_username1" {
  name         = var.admin-username
  key_vault_id = data.azurerm_key_vault.kv.id
}

data "azurerm_key_vault_secret" "vm_password1" {
  name         = var.admin-password
  key_vault_id = data.azurerm_key_vault.kv.id
}

