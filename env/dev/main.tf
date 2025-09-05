module "rg" {
  source   = "../../modules/azurerm_resource_group"
  rg_name  = "LB_RG"
  location = "East US"

}

module "vnet" {
  depends_on    = [module.rg]
  source        = "../../modules/azurerm_virtual_network"
  vnet_name     = "LB_VNet"
  rg_name       = "LB_RG"
  location      = "East US"
  address_space = ["192.168.0.0/21"]
}

module "subnet" {
  depends_on       = [module.rg, module.vnet]
  source           = "../../modules/azurerm_subnet"
  vnet_name        = "LB_VNet"
  rg_name          = "LB_RG"
  subnet1          = "LB-Subnet1"
  subnet2          = "LB-Subnet2"
  subnet3          = "AzureBastionSubnet"
  subnet1_prefixes = ["192.168.1.0/24"]
  subnet2_prefixes = ["192.168.2.0/24"]
  subnet3_prefixes = ["192.168.3.0/24"]
}

module "pip" {
  depends_on        = [module.rg]
  source            = "../../modules/azurerm_public_ip"
  rg_name           = "LB_RG"
  location          = "East US"
  bastion_pip1_name = "Bastion-PIP1"
  lb_pip1_name      = "LB-PIP1"
  allocation_method = "Static"
  sku               = "Standard"
}

module "nic" {
  depends_on        = [module.rg, module.subnet, module.pip]
  source            = "../../modules/azurerm_network_interface"
  rg_name           = "LB_RG"
  location          = "East US"
  bastion_nic_name  = "Bastion-NIC1"
  lb_nic_name       = "LB-NIC1"
  bastion_sub5      = "AzureBastionSubnet"
  lb_sub6           = "LB-Subnet1"
  vnet_name         = "LB_VNet"
  bastion_pip1_name = "Bastion-PIP1"
  lb_pip1_name      = "LB-PIP1"
}

module "nsg" {
  depends_on = [module.rg]
  source     = "../../modules/azurerm_nsg"
  nsg_name   = "LB-NSG"
  rg_name    = "LB_RG"
  location   = "East US"
}

module "nic_nsg_assoc" {
  depends_on       = [module.rg, module.nic, module.nsg]
  source           = "../../modules/azurerm_nic_nsg_association"
  rg_name          = "LB_RG"
  bastion_nic_name = "Bastion-NIC1"
  lb_nic_name      = "LB-NIC1"
  nsg_name         = "LB-NSG"
  
}


module "bastion" {
  depends_on       = [module.rg, module.subnet, module.pip, module.nic]
  source           = "../../modules/azurerm_bastion_host"
  rg_name          = "LB_RG"
  location         = "East US"
  bastion_name     = "My-Bastion"
  vnet_name        = "LB_VNet"
  bastion_sub4     = "AzureBastionSubnet"
  bastion_pip2_name = "Bastion-PIP1"
  
}

module "lb" {
  depends_on                = [module.rg, module.subnet, module.pip]
  source                    = "../../modules/azurerm_lb"
  rg_name                   = "LB_RG"
  location                  = "East US"
  lb_name                   = "My-LB"
  sku                       = "Standard"
  frontend_pool_ip_name     = "LB-FrontendIPConfig"
  lb_pip2_name              = "LB-PIP1"
  
}
