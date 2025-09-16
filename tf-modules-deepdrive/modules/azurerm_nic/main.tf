resource "azurerm_network_interface" "bastion_nic1" {
  name                = var.nic_name
  location            = var.location
  resource_group_name = var.rg_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = data.azurerm_subnet.subnet5.id
    private_ip_address_allocation = "Dynamic"
  }
}

