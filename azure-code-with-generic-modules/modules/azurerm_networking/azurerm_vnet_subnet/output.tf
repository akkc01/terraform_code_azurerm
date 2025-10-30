# output "subnet_ids" {
#   description = "IDs of all subnets in all VNets"
#   value = {
#     for vnet_key, vnet in azurerm_virtual_network.vnet :
#     vnet_key => {
#       for subnet in vnet.subnet :
#       subnet.name => subnet.id
#     }
#   }
# }


# output "subnet_ids" {
#   description = "IDs of all subnets in all VNets"
#   value = {
#     for vnet_key, vnet in azurerm_virtual_network.vnet :
#     vnet_key => [
#       for subnet in vnet.subnet :
#       subnet.id
#     ]
#   }
# }


output "subnet_ids" {
  value = {
    for vnet_key, vnet in var.vnets :
    vnet_key => {
      for subnet_key, subnet in vnet.subnet :
      subnet_key => azurerm_subnet["${vnet_key}-${subnet_key}"].id
    }
  }
}
