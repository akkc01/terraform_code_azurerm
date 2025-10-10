module "rg" {
  source          = "../modules/azurerm_resource_group"
  resource_groups = var.resource_groups
}

module "storage" {
  source     = "../modules/azurerm_storage_account"
  stgaccount = var.stgaccount
}

module "virtual_networks"{
  source = "../modules/azurerm_virtual_network"
  virtual_networks = var.virtual_networks
  
}