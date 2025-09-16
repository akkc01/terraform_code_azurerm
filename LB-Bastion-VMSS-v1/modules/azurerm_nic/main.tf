# resource "azurerm_network_interface" "bastion_nic1" {
#   name                = var.bastion_nic_name
#   location            = var.location
#   resource_group_name = var.rg_name

#   ip_configuration {
#     name                          = "internal"
#     subnet_id                     = data.azurerm_subnet.bastion_sub5.id
#     private_ip_address_allocation = "Dynamic"
#   }
# }

resource "azurerm_network_interface" "lb_nic1" {
  name                = var.lb_nic_name
  location            = var.location
  resource_group_name = var.rg_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = data.azurerm_subnet.lb_sub6.id
    private_ip_address_allocation = "Dynamic"
  }
}
