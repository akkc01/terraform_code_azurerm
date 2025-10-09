module "rg" {
  source          = "../modules/azurerm_resource_group"
  resource_groups = var.resource_groups
}

module "storage" {
  source     = "../modules/azurerm_storage_account"
  stgaccount = var.stgaccount
}

