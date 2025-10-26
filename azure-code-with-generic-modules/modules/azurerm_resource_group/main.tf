resource "azurerm_resource_group" "rg" {
  for_each   = var.resource_groups
  
  name       = each.value.name
  location   = each.value.location
  # managed_by = each.value.managed_by
  # tags       = each.value.tags
  managed_by = lookup(each.value, "managed_by", "terraform")
  tags       = lookup(each.value, "tags", {})
}




