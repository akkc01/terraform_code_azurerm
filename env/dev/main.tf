module "rg" {
  source   = "../../modules/azurerm_resource_group"
  rg_name  = "AKKC_LB_RG01"
  location = "southeastasia"

}

module "vnet" {
  depends_on    = [module.rg]
  source        = "../../modules/azurerm_virtual_network"
  vnet_name     = "AKKC_LB_VNet"
  rg_name       = "AKKC_LB_RG01"
  location      = "southeastasia"
  address_space = ["192.168.0.0/21"]
}

module "subnet" {
  depends_on       = [module.rg, module.vnet]
  source           = "../../modules/azurerm_subnet"
  vnet_name        = "AKKC_LB_VNet"
  rg_name          = "AKKC_LB_RG01"
  subnet1          = "AKKC_LB-Subnet1"
  subnet2          = "AKKC_LB-Subnet2"
  subnet4          = "application-gateway-subnet"
  subnet1_prefixes = ["192.168.1.0/24"]
  subnet2_prefixes = ["192.168.2.0/24"]
  subnet4_prefixes = ["192.168.4.0/24"]
}

module "pip" {
  depends_on        = [module.rg]
  source            = "../../modules/azurerm_public_ip"
  rg_name           = "AKKC_LB_RG01"
  location          = "southeastasia"
  appgw_pip_name    = "akkcAppGwPIP"
  allocation_method = "Static"
  sku               = "Standard"
}
module "nsg" {
  depends_on = [module.rg]
  source     = "../../modules/azurerm_nsg"
  nsg_name   = "AKKC_LB-NSG"
  rg_name    = "AKKC_LB_RG01"
  location   = "southeastasia"
}

module "sub_nsg_assoc" {
  depends_on        = [module.rg, module.vnet, module.subnet, module.nsg]
  source            = "../../modules/azurerm_subnet_nsg_association"
  rg_name           = "AKKC_LB_RG01"
  vnet_name         = "AKKC_LB_VNet"
  nsg_name          = "AKKC_LB-NSG"
  appgw_subnet_name = "application-gateway-subnet"
}



module "kv" {
  depends_on = [module.rg]
  source     = "../../modules/azurerm_key_vault_and_secrets"
  kv_name    = "akkckeyvault101"
  rg_name    = "AKKC_LB_RG01"
  location   = "southeastasia"
  vm-password = "vm-password"
  vm_secrets = {
    vm1 = {
      secret_name = "vm1-username"
      secret_pass = "vm1-password"
    }
    # vm2 = {
    #   secret_name = "vm2-username"
    #   secret_pass = "vm2-password"
    # }
    sql = {
      secret_name = "sql-username"
      secret_pass = "sql-password"
    }
  }
}

module "sql_server" {
  depends_on      = [module.rg, module.kv, module.kvs]
  source          = "../../modules/azurerm_mssql_server"
  sql_server_name = "akkcsqlserver007"
  rg_name         = "AKKC_LB_RG01"
  location        = "southeastasia"
  sql-user        = "sql-username"
  sql-pass        = "sql-password"
}

module "sql_db" {
  depends_on      = [module.rg, module.kv, module.kvs, module.sql_server]
  source          = "../../modules/azurerm_mssql_database"
  db_name         = "courses"
  sql_server_name = "akkcsqlserver007"
  rg_name         = "AKKC_LB_RG01"
}


module "appgw" {
  depends_on                     = [module.rg, module.vnet, module.subnet, module.pip, module.kv]
  source                         = "../../modules/azurerm_application_gateway"
  appgw_name                     = "akkcappgw007"
  appgw_pip_name                 = "akkcAppGwPIP"
  rg_name                        = "AKKC_LB_RG01"
  location                       = "southeastasia"
  vnet_name                      = "AKKC_LB_VNet"
  subnet                         = "application-gateway-subnet"
  frontend_port_name             = "frontendPort"
  frontend_ip_configuration_name = "frontendIP"
  backend_address_pool_name1     = "backendPool1"
  http_setting_name1             = "httpSettings1"
  http_listener_name1            = "httpListener1"
  request_routing_rule_name1     = "RRRule1"

}


module "vmss1" {
  depends_on        = [module.rg, module.vnet, module.subnet, module.nsg, module.kv, module.appgw]
  source            = "../../modules/azurerm_linux_virtual_machine_scale_set"
  vmss_name         = "AKKC_VMSS"
  rg_name           = "AKKC_LB_RG01"
  location          = "southeastasia"
  sku               = "Standard_F2"
  admin-username    = "vm1-username"
  admin-password    = "vm1-password"
  vnet_name         = "AKKC_LB_VNet"
  vmss_sub          = "AKKC_LB-Subnet2"
  backend_pool_name = "backendPool1"
  nsg_name          = "AKKC_LB-NSG"
  appgw_name        = "akkcappgw007"
  kv_name           = "akkckeyvault101"
  autoscale_name    = "vmssAutoScale"
}


