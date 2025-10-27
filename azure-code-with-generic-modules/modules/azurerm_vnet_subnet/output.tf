output "subnet_ids" {
  description = "IDs of all subnets in all VNets"
  value = {
    for vnet_key, vnet in azurerm_virtual_network.vnet :
    vnet_key => {
      for subnet in vnet.subnet :
      subnet.name => subnet.id
    }
  }
}



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

