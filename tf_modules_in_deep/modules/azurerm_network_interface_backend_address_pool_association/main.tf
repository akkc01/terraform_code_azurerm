# resource "azurerm_network_interface_backend_address_pool_association" "example" {
#   network_interface_id    = azurerm_network_interface.example.id
#   ip_configuration_name   = "testconfiguration1"
#   backend_address_pool_id = azurerm_lb_backend_address_pool.example.id
# }