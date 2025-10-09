resource "azurerm_resource_group" "name" {
  for_each   = var.resource_groups
  
  name       = each.value.name
  location   = each.value.location
  managed_by = each.value.managed_by
  tags       = each.value.tags
}




