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
  depends_on = [module.rg, module.vnet]
  source     = "../../modules/azurerm_subnet"
  vnet_name  = "AKKC_LB_VNet"
  rg_name    = "AKKC_LB_RG01"
  subnet1    = "AKKC_LB-Subnet1"
  subnet2    = "AKKC_LB-Subnet2"
  subnet4          = "application-gateway-subnet"
  subnet1_prefixes = ["192.168.1.0/24"]
  subnet2_prefixes = ["192.168.2.0/24"]
  subnet4_prefixes = ["192.168.4.0/24"]
}

module "pip" {
  depends_on = [module.rg]
  source     = "../../modules/azurerm_public_ip"
  rg_name    = "AKKC_LB_RG01"
  location   = "southeastasia"
  appgw_pip_name    = "akkcAppGwPIP"
  allocation_method = "Static"
  sku               = "Standard"
}


module "nic" {
  depends_on   = [module.rg, module.subnet]
  source       = "../../modules/azurerm_nic"
  rg_name      = "AKKC_LB_RG01"
  location     = "southeastasia"
  vm1_nic_name = "AKKC_VM1-NIC"
  vm2_nic_name = "AKKC_VM2-NIC"
  vm_sub       = "AKKC_LB-Subnet1"
  vnet_name    = "AKKC_LB_VNet"
}

module "nsg" {
  depends_on = [module.rg]
  source     = "../../modules/azurerm_nsg"
  nsg_name   = "AKKC_LB-NSG"
  rg_name    = "AKKC_LB_RG01"
  location   = "southeastasia"
}

module "nic_nsg_assoc" {
  depends_on   = [module.rg, module.nic, module.nsg]
  source       = "../../modules/azurerm_nic_nsg_association"
  rg_name      = "AKKC_LB_RG01"
  vnet_name    = "AKKC_LB_VNet"
  nsg_name     = "AKKC_LB-NSG"
  vm1_nic_name = "AKKC_VM1-NIC"
  vm2_nic_name = "AKKC_VM2-NIC"
  subnet_name = "AKKC_LB-Subnet1"
  appgw_subnet_name = "application-gateway-subnet"
}

module "kv" {
  depends_on = [module.rg]
  source     = "../../modules/azurerm_key_vault"
  kv_name    = "AKKCKEYVAULT007"
  rg_name    = "AKKC_LB_RG01"
  location   = "southeastasia"
}

module "kvs" {
  depends_on = [module.rg, module.kv]
  source     = "../../modules/azurerm_key_vault_secrets"
  kv_name    = "AKKCKEYVAULT007"
  rg_name    = "AKKC_LB_RG01"
  vm_secrets = {
    vm1 = {
      secret_name = "vm1-username"
      secret_pass = "vm1-password"
    }
    vm2 = {
      secret_name = "vm2-username"
      secret_pass = "vm2-password"
    }
    sql = {
      secret_name = "sql-username"
      secret_pass = "sql-password"
    }
  }
}

module "vm1" {
  source      = "../../modules/azurerm_linux_virtual_machine"
  depends_on  = [module.rg, module.nic, module.kv, module.kvs]
  rg_name     = "AKKC_LB_RG01"
  location    = "southeastasia"
  vm_name     = "AKKCVM1"
  vm_size     = "Standard_F2"
  vm_nic_name = "AKKC_VM1-NIC"
  kv_name     = "AKKCKEYVAULT007"
  vmpass      = "vm1-password"
  vmuser      = "vm1-username"
}

module "vm2" {
  source      = "../../modules/azurerm_linux_virtual_machine"
  depends_on  = [module.rg, module.nic, module.kv, module.kvs]
  rg_name     = "AKKC_LB_RG01"
  location    = "southeastasia"
  vm_name     = "AKKCVM2"
  vm_size     = "Standard_F2"
  vm_nic_name = "AKKC_VM2-NIC"
  kv_name     = "AKKCKEYVAULT007"
  vmpass      = "vm2-password"
  vmuser      = "vm2-username"
}

# module "sql_server" {
#   depends_on      = [module.rg, module.kv, module.kvs]
#   source          = "../../modules/azurerm_mssql_server"
#   sql_server_name = "akkcsqlserver007"
#   rg_name         = "AKKC_LB_RG01"
#   location        = "southeastasia"
#   sql-user        = "sql-username"
#   sql-pass        = "sql-password"
# }

# module "sql_db" {
#   depends_on      = [module.rg, module.kv, module.kvs, module.sql_server]
#   source          = "../../modules/azurerm_mssql_database"
#   db_name         = "courses"
#   sql_server_name = "akkcsqlserver007"
#   rg_name         = "AKKC_LB_RG01"
# }

module "appgw" {
  depends_on                     = [module.rg, module.vnet, module.subnet, module.pip, module.vm1, module.vm2]
  source                         = "../../modules/azurerm_application_gateway"
  appgw_name                     = "akkcappgw007"
  appgw_pip_name                 = "akkcAppGwPIP"
  rg_name                        = "AKKC_LB_RG01"
  location                       = "southeastasia"
  vnet_name                      = "AKKC_LB_VNet"
  subnet                         = "application-gateway-subnet"
  frontend_port_name             = "frontendPort"
  frontend_ip_configuration_name = "frontendIP"
  backend_address_pool_name      = "backendPool"
  http_setting_name              = "httpSettings"
  http_listener_name             = "httpListener"
  request_routing_rule_name      = "RRRule1"
  vm1_nic_name                   = "AKKC_VM1-NIC"
  vm2_nic_name                   = "AKKC_VM2-NIC"
  healthProbe                    = "appgw-health-probe"
}

