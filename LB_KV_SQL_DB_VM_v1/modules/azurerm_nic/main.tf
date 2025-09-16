resource "azurerm_network_interface" "vm1_nic" {
  name                = var.vm1_nic_name
  location            = var.location
  resource_group_name = var.rg_name

  ip_configuration {
    name                          = "vm-prvate_ip-config"
    subnet_id                     = data.azurerm_subnet.vm_sub.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_network_interface" "vm2_nic" {
  name                = var.vm2_nic_name
  location            = var.location
  resource_group_name = var.rg_name

  ip_configuration {
    name                          = "vm-prvate_ip-config"
    subnet_id                     = data.azurerm_subnet.vm_sub.id
    private_ip_address_allocation = "Dynamic"
  }
}
