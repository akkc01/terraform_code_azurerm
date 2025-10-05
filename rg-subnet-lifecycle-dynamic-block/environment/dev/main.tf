module "rg" {
  source              = "../../modules/azurerm_resource_group"
  resource_group_name = var.resource_group_name
  location            = var.location
  tags                = var.tags
}

# module "vnet-subnet" {
#     depends_on = [ module.rg, module.nsg ]
#   source               = "../../modules/azurerm_virtual_network_and_subnet"
#   virtual_network_name = var.virtual_network_name
#   address_space        = var.address_space
#   location             = var.location
#   resource_group_name  = var.resource_group_name
#   subnets              = var.subnets
#   tags                = var.tags
# }

module "nsg" {
    depends_on = [ module.rg ]
  source              = "../../modules/azurerm_nsg"
  resource_group_name = var.resource_group_name
  location            = var.location
  security_rules      = var.security_rules
  nsg_name            = var.nsg_name    
  tags                = var.tags
}