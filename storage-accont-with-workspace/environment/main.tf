module "rg" {
  source              = "../modules/azurerm_resource_group"
  resource_group_name = "${var.resource_group_name}-${var.location}-${terraform.workspace}"
  location            = var.location
  tags                = var.tags
}


module "storage" {
  source                   = "../modules/azurerm_storage_account"
  stg_name                 = "${var.stg_name}${var.location}${terraform.workspace}"
  resource_group_name      = "${var.resource_group_name}-${var.location}-${terraform.workspace}"
  location                 = var.location
  tags                     = var.tags
  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type
  access_tier              = var.access_tier

}

