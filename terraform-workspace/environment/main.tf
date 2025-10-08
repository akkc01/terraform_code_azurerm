module "rg" {
  source              = "../modules/azurerm_resource_group"
  resource_group_name = "rg-maneesh-${terraform.workspace}"
  location            = var.location
  tags                = var.tags
}


module "nsg" {
  depends_on          = [module.rg]
  source              = "../modules/azurerm_nsg"
  resource_group_name = "rg-maneesh-${terraform.workspace}"
  location            = var.location
  security_rules      = var.security_rules
  nsg_name            = "${var.nsg_name}-${terraform.workspace}"
  tags                = var.tags
}
