resource "azurerm_network_interface" "nic" {
  for_each = var.nics

  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  ip_configuration {
    name                          = each.value.ip_configuration_name
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = each.value.private_ip_address_allocation
    private_ip_address_version    = each.value.private_ip_address_version
  }
}

