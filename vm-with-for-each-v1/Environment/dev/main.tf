module "rg" {
  source = "../../Module/azurerm_resource_group"
  rg     = var.rg
}

module "vnet" {
  source     = "../../Module/azurerm_virtual_network"
  depends_on = [module.rg]
  vnet       = var.vnet

}

module "subnet" {
  source     = "../../Module/azurerm_subnet"
  depends_on = [module.vnet]
  subnet       = var.subnet

}

module "pip" {
  source     = "../../Module/azurerm_public_ip"
  depends_on = [module.rg]
  pip        = var.pip
}

module "nic" {
  source        = "../../Module/azurerm_network_interface"
  depends_on    = [module.pip, module.subnet]
  nic           = var.nic
}


module "vm" {
  source     = "../../Module/azurerm_virtual_machine"
  depends_on = [module.nic]
  vm         = var.vm
}

module "nsg" {
  source     = "../../Module/azurerm_network_security_group"
  depends_on = [module.vm]
  nsg        = var.nsg
}

module "nic-association" {
  source        = "../../Module/azurerm_network_interface_security_group_association"
  depends_on    = [module.nic, module.nsg, module.vm]
  nsg-nic-association = var.nsg-nic-association

}

