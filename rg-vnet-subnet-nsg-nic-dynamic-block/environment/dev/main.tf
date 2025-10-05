module "rg" {
  source              = "../../modules/azurerm_resource_group"
  resource_group_name = var.resource_group_name
  location            = var.location
}

module "vnet-subnet" {
  depends_on           = [module.rg, module.nsg]
  source               = "../../modules/azurerm_virtual_network_and_subnet"
  virtual_network_name = var.virtual_network_name
  address_space        = var.address_space
  location             = var.location
  resource_group_name  = var.resource_group_name
  subnets              = var.subnets
  nsg_id               = module.nsg.nsg_id
}

module "nsg" {
  depends_on          = [module.rg]
  source              = "../../modules/azurerm_nsg"
  resource_group_name = var.resource_group_name
  location            = var.location
  security_rules      = var.security_rules
  nsg_name            = var.nsg_name
}

module "nic" {
  depends_on = [module.rg, module.vnet-subnet]
  source     = "../../modules/azurerm_nic"
  nics       = var.nics
  subnet_id  = module.nic.subnet_ids[0]
  subnets1 = var.subnets1
}
