resource "azurerm_bastion_host" "bastion1" {
  name                = var.bastion_name
  location            = var.location
  resource_group_name = var.rg_name

  ip_configuration {
    name                 = "configuration"
    subnet_id            = data.azurerm_subnet.bastion_sub4.id
    public_ip_address_id = data.azurerm_public_ip.bastion_pip2.id
  }
}
