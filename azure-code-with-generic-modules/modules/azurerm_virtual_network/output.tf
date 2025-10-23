output "subnet_ids" {
  value = {
    for vnet_key, vnet in azurerm_virtual_network.vnet : vnet_key => [
      for s in vnet.subnet : s.id
    ]
  }
}
