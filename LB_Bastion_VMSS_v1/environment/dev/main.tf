module "rg" {
  source   = "../../modules/azurerm_resource_group"
  rg_name  = "VMSS-RG"
  location = "eastasia"
}

module "vnet" {
  depends_on    = [module.rg]
  source        = "../../modules/azurerm_virtual_network"
  vnet_name     = "VMSS-VNET"
  address_space = ["192.168.0.0/21"]
  location      = "eastasia"
  rg_name       = module.rg.rg_name
}

module "subnet" {
  depends_on       = [module.rg, module.vnet]
  source           = "../../modules/azurerm_subnet"
  subnet1          = "VMSS-SUBNET1"
  subnet2          = "VMSS-SUBNET2"
  subnet3          = "AzureBastionSubnet"
  rg_name          = module.rg.rg_name
  vnet_name        = module.vnet.vnet_name
  location         = "eastasia"
  subnet1_prefixes = ["192.168.1.0/24"]
  subnet2_prefixes = ["192.168.2.0/24"]
  subnet3_prefixes = ["192.168.3.0/24"]
}

module "public_ip" {
  depends_on        = [module.rg]
  source            = "../../modules/azurerm_public_ip"
  bastion_pip1_name = "VMSS-Bastion-PIP"
  lb_pip1_name      = "VMSS-LB-PIP"
  rg_name           = module.rg.rg_name
  location          = "eastasia"
  allocation_method = "Static"
  sku               = "Standard"
}

module "nic" {
  depends_on = [module.rg, module.vnet, module.subnet]
  source     = "../../modules/azurerm_nic"
  #bastion_nic_name = "bastion-NIC1"
  lb_nic_name  = "lb-NIC1"
  rg_name      = module.rg.rg_name
  location     = "eastasia"
  vnet_name    = module.vnet.vnet_name
  bastion_sub5 = "AzureBastionSubnet"
  lb_sub6      = module.subnet.subnet1

}


module "nsg" {
  depends_on = [module.rg]
  source     = "../../modules/azurerm_nsg"
  nsg_name   = "VMSS-NSG"
  rg_name    = module.rg.rg_name
  location   = "eastasia"
}

module "nic_nsg_association" {
  depends_on = [module.rg, module.nsg, module.nic]
  source     = "../../modules/azurerm_nic_nsg_association"
  nsg_name   = "VMSS-NSG"
  #bastion_nic_name = "bastion-NIC1"
  lb_nic_name = "lb-NIC1"
  rg_name     = module.rg.rg_name
}


module "bastion" {
  depends_on     = [module.rg, module.vnet, module.subnet, module.public_ip, module.nic, module.nsg, module.nic_nsg_association]
  source         = "../../modules/azurerm_bastion_host"
  bastion_name   = "VMSS-BASTION"
  rg_name        = module.rg.rg_name
  location       = "eastasia"
  bastion_sub_id = module.subnet.bastion_sub_id
  vnet_name      = "VMSS-VNET"
  bastion_pip_id = module.public_ip.bastion_pip_id
}

module "lb" {
  depends_on            = [module.rg, module.vnet, module.subnet, module.public_ip, module.nic, module.nsg, module.nic_nsg_association]
  source                = "../../modules/azurerm_lb"
  lb_name               = "VMSS-LB"
  rg_name               = module.rg.rg_name
  location              = "eastasia"
  sku                   = "Standard"
  frontend_pool_ip_name = "VMSS-FrontendIP"
  lb_pip2_name          = "VMSS-LB-PIP"

}

module "lb_backend_address_pool" {
  depends_on        = [module.lb]
  source            = "../../modules/azurerm_lb_backend_address_pool"
  lb_name           = "VMSS-LB"
  rg_name           = module.rg.rg_name
  vnet_name         = module.vnet.vnet_name
  backend_pool_name = "VMSS-BackendPool"

}

module "lb_probe" {
  depends_on        = [module.lb]
  source            = "../../modules/azurerm_lb_probe"
  health_probe_name = "http-probe"
  lb_name           = "VMSS-LB"
  rg_name           = module.rg.rg_name
}

module "lb_rule" {
  depends_on            = [module.lb, module.lb_backend_address_pool, module.lb_probe]
  source                = "../../modules/azurerm_lb_rule"
  lb_rule_name          = "HTTP-RULE"
  frontend_pool_ip_name = "VMSS-FrontendIP"
  lb_name               = "VMSS-LB"
  rg_name               = module.rg.rg_name
  backend_pool_name     = "VMSS-BackendPool"
  probe_id              = module.lb_probe.probe_id

}

module "vmss" {
  depends_on        = [module.rg, module.vnet, module.subnet, module.lb, module.lb_backend_address_pool, module.lb_probe, module.lb_rule]
  source            = "../../modules/azurerm_linux_virtual_machine_scale_set"
  vmss_name         = "VMSS-1"
  rg_name           = module.rg.rg_name
  location          = "eastasia"
  sku               = "Standard_F2"
  admin_username    = "adminuser"
  admin_password    = "Devops@12345" # ⚠️ Strong password hona chahiye
  vnet_name         = module.vnet.vnet_name
  vmss_sub7         = module.subnet.subnet1
  autoscale_name    = "VMSS-Autoscale"
  backend_pool_name = "VMSS-BackendPool"
  lb_name           = "VMSS-LB"
  nsg_name          = "VMSS-NSG"

}

