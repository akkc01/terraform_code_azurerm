module "rg" {
  source   = "../../modules/azurerm_resource_group"
  rg_name  = "VMSS-RG"
  location = "eastasia"
}

module "vnet" {
  source        = "../../modules/azurerm_virtual_network"
  vnet_name     = "VMSS-VNET"
  address_space = ["192.168.0.0/21"]
  location      = "eastasia"
  rg_name       = "VMSS-RG"
}

module "subnet" {
  source           = "../../modules/azurerm_subnet"
  subnet1          = "VMSS-SUBNET1"
  subnet2          = "VMSS-SUBNET2"
  subnet3          = "AzureBastionSubnet"
  rg_name          = "eastasia"
  vnet_name        = "VMSS-VNET"
  subnet1_prefixes = ["192.168.1.0/24"]
  subnet2_prefixes = ["192.168.2.0/24"]
  subnet3_prefixes = ["192.168.3.0/24"]
}

module "public_ip" {
  source            = "../../modules/azurerm_public_ip"
  bastion_pip1_name = "VMSS-Bastion-PIP"
  rg_name           = "VMSS-RG"
  location          = "eastasia"
  allocation_method = "Static"
  sku               = "Standard"

}

module "nic" {
  source                = "../../modules/azurerm_network_interface"
  nic_name              = "VMSS-NIC1"
  rg_name               = "VMSS-RG"
  location              = "eastasia"
  subnet_name           = "VMSS-SUBNET1"
  vnet_name             = "VMSS-VNET"
  private_ip_allocation = "Dynamic"
  
}


module "nsg" {
  source   = "../../modules/azurerm_nsg"
  nsg_name = "VMSS-NSG"
  rg_name  = "VMSS-RG"
  location = "eastasia"
}

module "nic_nsg_association" {
  source          = "../../modules/azurerm_nic_nsg_association"
  nsg_id          = module.nsg.nsg_id
  network_interface_id = module.vmss.vmss_nic_id
  
}


module "bastion" {
  source               = "../../modules/azurerm_bastion"
  bastion_name         = "VMSS-BASTION"
  rg_name              = "VMSS-RG"
  location             = "eastasia"
  bastion_subnet_id    = module.subnet.subnet3_id
  public_ip_id         = module.public_ip.pip1_id
}



module "name" {
  
}