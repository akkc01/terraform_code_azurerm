resource "azurerm_resource_group" "rg" {
  for_each = var.resource_groups

  name       = upper("${each.value.rg_name}-${each.value.tags["environment"]}-${each.value.location}-${each.value.tags["team"]}-${var.owner}")
  location   = each.value.location
  managed_by = lower(lookup(each.value, "managed_by", null))
  tags       = lookup(each.value, "tags", {})
}



variable "owner" {
    description = "The environment for resource group naming"
    type        = string
    default = "Tony-Stark"
  
}

