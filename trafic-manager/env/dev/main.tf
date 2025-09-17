module "rg1" {
  source   = "../../modules/azurerm_resource_group"
  rg_name  = "dev-rg1"
  location = "southeastasia"
}

module "rg2" {
  source   = "../../modules/azurerm_resource_group"
  rg_name  = "dev-rg2"
  location = "westus"
}

module "vnet1" {
  depends_on    = [module.rg1]
  source        = "../../modules/azurerm_virtual_network"
  vnet_name     = "dev-rg1-vnet1"
  rg_name       = module.rg1.rg-name
  location      = "southeastasia"
  address_space = ["192.168.0.0/21"]
}

module "vnet2" {
  depends_on    = [module.rg2]
  source        = "../../modules/azurerm_virtual_network"
  vnet_name     = "dev-rg2-vnet1"
  rg_name       = module.rg2.rg-name
  location      = "westus"
  address_space = ["172.16.0.0/21"]
}

module "subnet1" {
  depends_on       = [module.rg1, module.vnet1]
  source           = "../../modules/azurerm_subnet"
  vnet_name        = "dev-rg1-vnet1"
  rg_name          = module.rg1.rg-name
  subnet1          = "dev-rg1-vnet1-subnet1"
  subnet2          = "dev-rg1-vnet1-subnet2"
  subnet4          = "application-gateway-subnet"
  subnet1_prefixes = ["192.168.1.0/24"]
  subnet2_prefixes = ["192.168.2.0/24"]
  subnet4_prefixes = ["192.168.3.0/24"]
}

module "subnet2" {
  depends_on       = [module.rg2, module.vnet2]
  source           = "../../modules/azurerm_subnet"
  vnet_name        = "dev-rg2-vnet1"
  rg_name          = module.rg2.rg-name
  subnet1          = "dev-rg2-vnet1-subnet1"
  subnet2          = "dev-rg2-vnet1-subnet2"
  subnet4          = "application-gateway-subnet"
  subnet1_prefixes = ["172.16.1.0/24"]
  subnet2_prefixes = ["172.16.2.0/24"]
  subnet4_prefixes = ["172.16.3.0/24"]


}


module "pip1" {
  depends_on        = [module.rg1]
  source            = "../../modules/azurerm_public_ip"
  rg_name           = module.rg1.rg-name
  location          = "southeastasia"
  appgw_pip_name    = "AppGwPIP1"
  allocation_method = "Static"
  sku               = "Standard"
  domain_name_label = "my-appgw-southeastasia"
}

module "pip2" {
  depends_on        = [module.rg2]
  source            = "../../modules/azurerm_public_ip"
  rg_name           = module.rg2.rg-name
  location          = "westus"
  appgw_pip_name    = "AppGwPIP2"
  allocation_method = "Static"
  sku               = "Standard"
  domain_name_label = "my-appgw-westus"
}

module "nsg1" {
  depends_on = [module.rg1]
  source     = "../../modules/azurerm_nsg"
  nsg_name   = "dev-nsg1"
  rg_name    = module.rg1.rg-name
  location   = "southeastasia"
}

module "nsg2" {
  depends_on = [module.rg2]
  source     = "../../modules/azurerm_nsg"
  nsg_name   = "dev-nsg2"
  rg_name    = module.rg2.rg-name
  location   = "westus"
}

module "sub_nsg_assoc1" {
  depends_on        = [module.rg1, module.vnet1, module.subnet1, module.nsg1]
  source            = "../../modules/azurerm_subnet_nsg_association"
  rg_name           = module.rg1.rg-name
  vnet_name         = "dev-rg1-vnet1"
  nsg_name          = "dev-nsg1"
  appgw_subnet_name = "application-gateway-subnet"
}

module "sub_nsg_assoc2" {
  depends_on        = [module.rg2, module.vnet2, module.subnet2, module.nsg2]
  source            = "../../modules/azurerm_subnet_nsg_association"
  rg_name           = module.rg2.rg-name
  vnet_name         = "dev-rg2-vnet1"
  nsg_name          = "dev-nsg2"
  appgw_subnet_name = "application-gateway-subnet"
}



module "kv1" {
  depends_on = [module.rg1]
  source     = "../../modules/azurerm_key_vault_and_secrets"
  kv_name    = "devkeyvault101"
  rg_name    = module.rg1.rg-name
  location   = "southeastasia"
  vm_secrets = {
    vm1 = {
      secret_name = "vmss1-username"
      secret_pass = "vmss1-password"
    }
    vm2 = {
      secret_name = "vmss2-username"
      secret_pass = "vmss2-password"
    }
  }
}

module "kv2" {
  depends_on = [module.rg2]
  source     = "../../modules/azurerm_key_vault_and_secrets"
  kv_name    = "devkeyvault102"
  rg_name    = module.rg2.rg-name
  location   = "westus"
  vm_secrets = {
    vm1 = {
      secret_name = "vmss1-username"
      secret_pass = "vmss1-password"
    }
    vm2 = {
      secret_name = "vmss2-username"
      secret_pass = "vmss2-password"
    }
  }
}


module "appgw1" {
  depends_on                     = [module.rg1, module.vnet1, module.subnet1, module.pip1, module.kv1]
  source                         = "../../modules/azurerm_application_gateway"
  appgw_name                     = "devappgw001"
  appgw_pip_name                 = "AppGwPIP1"
  rg_name                        = module.rg1.rg-name
  location                       = "southeastasia"
  vnet_name                      = "dev-rg1-vnet1"
  subnet                         = "application-gateway-subnet"
  frontend_port_name             = "frontendPort"
  frontend_ip_configuration_name = "frontendIP"
  backend_address_pool_name1     = "backendPool1"
  http_setting_name1             = "httpSettings1"
  http_listener_name1            = "httpListener1"
  request_routing_rule_name1     = "RRRule1"
  ssl_cert_password              = "Kait@12azure"

}


module "appgw2" {
  depends_on                     = [module.rg2, module.vnet2, module.subnet2, module.pip2, module.kv2]
  source                         = "../../modules/azurerm_application_gateway"
  appgw_name                     = "devappgw002"
  appgw_pip_name                 = "AppGwPIP2"
  rg_name                        = module.rg2.rg-name
  location                       = "westus"
  vnet_name                      = "dev-rg2-vnet1"
  subnet                         = "application-gateway-subnet"
  frontend_port_name             = "frontendPort"
  frontend_ip_configuration_name = "frontendIP"
  backend_address_pool_name1     = "backendPool1"
  http_setting_name1             = "httpSettings1"
  http_listener_name1            = "httpListener1"
  request_routing_rule_name1     = "rrrule1"
  ssl_cert_password              = "Kait@12azure"

}



module "vmss1" {
  depends_on        = [module.rg1, module.vnet1, module.subnet1, module.nsg1, module.kv1, module.appgw1]
  source            = "../../modules/azurerm_linux_virtual_machine_scale_set"
  vmss_name         = "dev-vmss01"
  rg_name           = module.rg1.rg-name
  location          = "southeastasia"
  sku               = "Standard_F2"
  admin-username    = "vmss1-username"
  admin-password    = "vmss1-password"
  vnet_name         = "dev-rg1-vnet1"
  vmss_sub          = "dev-rg1-vnet1-subnet1"
  backend_pool_name = "backendPool1"
  nsg_name          = "dev-nsg1"
  appgw_name        = "devappgw001"
  kv_name           = "devkeyvault101"
  autoscale_name    = "vmssAutoScale"
}

module "vmss2" {
  depends_on        = [module.rg2, module.vnet2, module.subnet2, module.nsg2, module.kv2, module.appgw2]
  source            = "../../modules/azurerm_linux_virtual_machine_scale_set"
  vmss_name         = "dev-vmss02"
  rg_name           = module.rg2.rg-name
  location          = "westus"
  sku               = "Standard_F2"
  admin-username    = "vmss2-username"
  admin-password    = "vmss2-password"
  vnet_name         = "dev-rg2-vnet1"
  vmss_sub          = "dev-rg2-vnet1-subnet1"
  backend_pool_name = "backendPool1"
  nsg_name          = "dev-nsg2"
  appgw_name        = "devappgw002"
  kv_name           = "devkeyvault102"
  autoscale_name    = "vmssAutoScale"
}


module "traffic_mgr" {
  depends_on = [module.rg1, module.rg2, module.vnet1, module.vnet2, module.subnet1, module.subnet1, module.pip1, module.pip2, module.kv1, module.kv2, module.appgw1, module.appgw2, module.vmss1, module.vmss2]
  source     = "../../modules/azurerm_traffic_manager_profile"
  rg_name    = module.rg1.rg-name
  appgw_pip1 = module.pip1.appgw_pip_id
  appgw_pip2 = module.pip2.appgw_pip_id

}

