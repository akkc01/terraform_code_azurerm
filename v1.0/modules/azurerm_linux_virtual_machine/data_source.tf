data "azurerm_network_interface" "vmnic" {
  name                = var.vm_nic_name
  resource_group_name = var.rg_name
}