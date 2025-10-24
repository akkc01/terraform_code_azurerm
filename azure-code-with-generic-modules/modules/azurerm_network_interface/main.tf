resource "azurerm_network_interface" "nic" {
  for_each = var.nics
  # Required arguments
  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  # Optional arguments
  auxiliary_mode                 = each.value.auxiliary_mode
  auxiliary_sku                  = each.value.auxiliary_sku
  dns_servers                    = each.value.dns_servers
  edge_zone                      = each.value.edge_zone
  ip_forwarding_enabled          = each.value.ip_forwarding_enabled
  accelerated_networking_enabled = each.value.accelerated_networking_enabled
  internal_dns_name_label        = each.value.internal_dns_name_label
  tags                           = each.value.tags

  # Required block: ip_configuration
  dynamic "ip_configuration" {
    for_each = each.value.ip_configuration != null ? each.value.ip_configuration : []  
    content {
      name                          = ip_configuration.value.name
      private_ip_address_allocation = ip_configuration.value.private_ip_address_allocation
    # Optional fields inside ip_configuration
      gateway_load_balancer_frontend_ip_configuration_id = ip_configuration.value.gateway_load_balancer_frontend_ip_configuration_id
      subnet_id                     = ip_configuration.value.subnet_id
      private_ip_address_version    = ip_configuration.value.private_ip_address_version
      public_ip_address_id          = ip_configuration.value.public_ip_address_id
      primary                       = ip_configuration.value.primary
      private_ip_address            = ip_configuration.value.private_ip_address
  }
}
}
