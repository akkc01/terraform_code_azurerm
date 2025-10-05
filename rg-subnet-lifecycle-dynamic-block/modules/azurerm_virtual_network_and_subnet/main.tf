# resource "azurerm_virtual_network" "name" {
#   name                = var.virtual_network_name
#   address_space       = var.address_space
#   location            = var.location
#   resource_group_name = var.resource_group_name
#   tags                = var.tags


#   dynamic "subnet" {
#     for_each = var.subnets
#     content {
#       name             = subnet.value.subnet
#       address_prefixes = subnet.value.address_prefixes
#     }

#   }

#     lifecycle {
#     create_before_destroy = true
#     prevent_destroy = true
#    ignore_changes        = [tags]
#   }
# }


removed {
  from    = azurerm_virtual_network.name
  lifecycle {
  destroy = false
}
}
