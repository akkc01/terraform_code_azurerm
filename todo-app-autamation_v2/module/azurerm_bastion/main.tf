resource "azurerm_bastion_host" "bastion" {
  name                = var.bastion_name
  location            = var.location
  resource_group_name = var.rg_name

  #dns_name = "bastiondemo${random_integer.rand.result}"  # Optional

  ip_configuration {
    name                 = "bastion-ip-config"
    subnet_id            = var.bastion_subnet_id
    public_ip_address_id = var.bastion_public_ip_id
  }
}

