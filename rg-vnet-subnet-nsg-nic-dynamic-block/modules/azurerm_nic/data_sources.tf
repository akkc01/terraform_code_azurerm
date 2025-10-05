data "azurerm_subnet" "subnets" {
  for_each = var.subnets1

  name                 = each.value.subnet
  virtual_network_name = each.value.virtual_network_name
  resource_group_name  = each.value.resource_group_name
}


