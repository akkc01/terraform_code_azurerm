data "azurerm_subnet" "vmss_sub" {
  name                 = var.vmss_sub
  virtual_network_name = var.vnet_name
  resource_group_name  = var.rg_name
}

#    *** used when vmss uses load balencer ****
# data "azurerm_lb" "lb4" {
#   name                = var.lb_name
#   resource_group_name = var.rg_name
# }

# data "azurerm_lb_backend_address_pool" "bepool3" {
#   name            = var.backend_pool_name
#   loadbalancer_id = data.azurerm_lb.lb4.id
# }

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

