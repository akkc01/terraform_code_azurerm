module "rg" {
  source          = "../../modules/azurerm_resource_group"
  resource_groups = var.resource_groups
}

module "vnet-subnet" {
  source           = "../../modules/azurerm_vnet_subnet"
  virtual_networks = var.virtual_networks
  depends_on       = [module.rg]
  rg_names         = module.rg.names
  rg_locations     = module.rg.locations
}

module "pip" {
  source       = "../../modules/azurerm_public_ip"
  public_ips   = var.public_ips
  depends_on   = [module.rg]
  rg_names     = module.rg.names
  rg_locations = module.rg.locations
}
