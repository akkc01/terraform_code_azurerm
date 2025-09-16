module "rg" {
  source   = "../../modules/azurerm_resource_group"
  rg_name  = "PROD-LB-RG01"
  location = "northcentralus"

}

module "vnet" {
  depends_on    = [module.rg]
  source        = "../../modules/azurerm_virtual_network"
  vnet_name     = "PROD-LB-VNet"
  rg_name       = "PROD-LB-RG01"
  location      = "northcentralus"
  address_space = ["192.168.0.0/21"]
}

module "subnet" {
  depends_on = [module.rg, module.vnet]
  source     = "../../modules/azurerm_subnet"
  vnet_name  = "PROD-LB-VNet"
  rg_name    = "PROD-LB-RG01"
  subnet1    = "PROD-LB-Subnet1"
  subnet2    = "PROD-LB-Subnet2"
  #subnet3          = "AzureBastionSubnet"
  subnet1_prefixes = ["192.168.1.0/24"]
  subnet2_prefixes = ["192.168.2.0/24"]
  subnet3_prefixes = ["192.168.3.0/24"]
}

module "pip" {
  depends_on        = [module.rg]
  source            = "../../modules/azurerm_public_ip"
  rg_name           = "PROD-LB-RG01"
  location          = "northcentralus"
  bastion_pip_name  = "PROD-Bastion-PIP1"
  lb_pip_name       = "PROD-LB-PIP1"
  allocation_method = "Static"
  sku               = "Standard"
}


module "nic" {
  depends_on   = [module.rg, module.subnet]
  source       = "../../modules/azurerm_nic"
  rg_name      = "PROD-LB-RG01"
  location     = "northcentralus"
  vm1_nic_name = "PROD-VM1-NIC"
  vm2_nic_name = "PROD-VM2-NIC"
  vm_sub       = "PROD-LB-Subnet1"
  vnet_name    = "PROD-LB-VNet"

}

module "nsg" {
  depends_on = [module.rg]
  source     = "../../modules/azurerm_nsg"
  nsg_name   = "PROD-LB-NSG"
  rg_name    = "PROD-LB-RG01"
  location   = "northcentralus"

}

module "nic_nsg_assoc" {
  depends_on   = [module.rg, module.nic, module.nsg]
  source       = "../../modules/azurerm_nic_nsg_association"
  rg_name      = "PROD-LB-RG01"
  vnet_name    = "PROD-LB-VNet"
  nsg_name     = "PROD-LB-NSG"
  vm1_nic_name = "PROD-VM1-NIC"
  vm2_nic_name = "PROD-VM2-NIC"
  #bastion_subnet_name = "AzureBastionSubnet"
  subnet_name = "PROD-LB-Subnet1"
}


module "lb" {
  depends_on       = [module.rg, module.subnet, module.pip, module.nic, module.nsg, module.nic_nsg_assoc]
  source           = "../../modules/azurerm_lb"
  rg_name          = "PROD-LB-RG01"
  location         = "northcentralus"
  lb_name          = "PROD-MY-LB"
  sku              = "Standard"
  frontend_ip_name = "LB-FrontendIPConfig"
  lb_pip_name1      = "PROD-LB-PIP1"
  vnet_name1        = "PROD-LB-VNet"
}


module "bepool" {
  depends_on = [ module.lb ]
  source            = "../../modules/azurerm_lb_backend_pool"
  lb_name           = "PROD-MY-LB"
  rg_name           = "PROD-LB-RG01"
  #vnet_name         = "PROD-LB-VNet"
  backend_pool_name = "PROD-BackendPool"
}

module "lb_probe" {
  depends_on = [ module.lb ]
  source            = "../../modules/azurerm_lb_probe"
  lb_name           = "PROD-MY-LB"
  rg_name           = "PROD-LB-RG01"
  health_probe_name = "LB-HealthProbe"
}

module "lb_rule" {
  depends_on = [ module.lb, module.lb_probe ]
  source            = "../../modules/azurerm_lb_rule"
  lb_name           = "PROD-MY-LB"
  rg_name           = "PROD-LB-RG01"
  lb_rule_name      = "LB-HTTPRule"
  frontend_ip_name  = "LB-FrontendIPConfig"
  backend_pool_name = "PROD-BackendPool"
  lbprobe_id        = module.lb_probe.probe_id
}


module "nic_lb_bepool_asso" {
depends_on            = [module.rg, module.nic, module.lb, module.bepool]
  source                = "../../modules/azurerm_nic_lb_bepool_association"
  vm1_nic_name          = "PROD-VM1-NIC"
  vm2_nic_name          = "PROD-VM2-NIC"
  rg_name               = "PROD-LB-RG01"
  backend_pool_name     = "PROD-BackendPool"
  lb_name               = "PROD-My-LB"
  ip_configuration_name = "vm-prvate_ip-config"

}


module "vm1" {
  source         = "../../modules/azurerm_linux_virtual_machine"
  depends_on     = [module.rg, module.nic,module.nic_nsg_assoc]
  rg_name        = "PROD-LB-RG01"
  location       = "northcentralus"
  vm_name        = "PRODVM1"
  vm_size        = "Standard_F2"
  admin_username = "PROD"
  admin_password = "Devops@12345"
  vm_nic_name    = "PROD-VM1-NIC"

}


module "vm2" {
  source         = "../../modules/azurerm_linux_virtual_machine"
 depends_on     = [module.rg, module.nic,module.nic_nsg_assoc]
  rg_name        = "PROD-LB-RG01"
  location       = "northcentralus"
  vm_name        = "PRODVM2"
  vm_size        = "Standard_F2"
  admin_username = "PROD"
  admin_password = "Devops@12345"
  vm_nic_name    = "PROD-VM2-NIC"

}

