module "rg" {
  source = "../../modules/azurerm_resource_group"
  rgs    = var.rgs
}
