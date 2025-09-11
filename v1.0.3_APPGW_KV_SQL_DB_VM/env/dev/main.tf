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
  #subnet3          = "AzureBastionSubnet"
  subnet4          = "application-gateway-subnet"
  subnet1_prefixes = ["192.168.1.0/24"]
  subnet2_prefixes = ["192.168.2.0/24"]
  #subnet3_prefixes = ["192.168.3.0/24"]
  subnet4_prefixes = ["192.168.4.0/24"]
}

module "pip" {
  depends_on = [module.rg]
  source     = "../../modules/azurerm_public_ip"
  rg_name    = "AKKC_LB_RG01"
  location   = "southeastasia"
  #bastion_pip_name  = "AKKC_Bastion-PIP1"
  #lb_pip_name       = "AKKC_LB-PIP1"
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
  #bastion_subnet_name = "AzureBastionSubnet"
  subnet_name = "AKKC_LB-Subnet1"
  appgw_subnet_name = "application-gateway-subnet"
}


# module "lb" {
#   depends_on       = [module.rg, module.subnet, module.pip, module.nic, module.nsg, module.nic_nsg_assoc]
#   source           = "../../modules/azurerm_lb"
#   rg_name          = "AKKC_LB_RG01"
#   location         = "southeastasia"
#   lb_name          = "AKKC_MY-LB"
#   sku              = "Standard"
#   frontend_ip_name = "LB-FrontendIPConfig"
#   lb_pip_name1     = "AKKC_LB-PIP1"
#   vnet_name1       = "AKKC_LB_VNet"
# }


# module "bepool" {
#   depends_on = [module.lb]
#   source     = "../../modules/azurerm_lb_backend_pool"
#   lb_name    = "AKKC_MY-LB"
#   rg_name    = "AKKC_LB_RG01"
#   #vnet_name        = "AKKC_LB_VNet"
#   backend_pool_name = "LB-BackendPool"

# }

# module "lb_probe" {
#   depends_on        = [module.lb]
#   source            = "../../modules/azurerm_lb_probe"
#   lb_name           = "AKKC_MY-LB"
#   rg_name           = "AKKC_LB_RG01"
#   health_probe_name = "LB-HealthProbe"
# }

# module "lb_rule" {
#   depends_on        = [module.lb, module.lb_probe, module.bepool]
#   source            = "../../modules/azurerm_lb_rule"
#   lb_name           = "AKKC_MY-LB"
#   rg_name           = "AKKC_LB_RG01"
#   lb_rule_name      = "LB-HTTPRule"
#   frontend_ip_name  = "LB-FrontendIPConfig"
#   backend_pool_name = "LB-BackendPool"
#   lbprobe_id        = module.lb_probe.probe_id
# }

# module "nic_lb_bepool_asso" {
#   depends_on            = [module.rg, module.nic, module.lb, module.bepool, module.lb_probe, module.lb_rule]
#   source                = "../../modules/azurerm_nic_lb_bepool_association"
#   vm1_nic_name          = "AKKC_VM1-NIC"
#   vm2_nic_name          = "AKKC_VM2-NIC"
#   rg_name               = "AKKC_LB_RG01"
#   backend_pool_name     = "LB-BackendPool"
#   lb_name               = "AKKC_MY-LB"
#   ip_configuration_name = "vm-prvate_ip-config"

# }

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

module "sql_server" {
  depends_on      = [module.rg, module.kv, module.kvs]
  source          = "../../modules/azurerm_mssql_server"
  sql_server_name = "akkcsqlserver007"
  rg_name         = "AKKC_LB_RG01"
  location        = "southeastasia"
  sql_user        = "sql-username"
  sql_pass        = "S3cure!P@ssw0rd12"
}

module "sql_db" {
  depends_on      = [module.rg, module.kv, module.kvs, module.sql_server]
  source          = "../../modules/azurerm_mssql_database"
  db_name         = "courses"
  sql_server_name = "akkcsqlserver007"
  rg_name         = "AKKC_LB_RG01"
}

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

