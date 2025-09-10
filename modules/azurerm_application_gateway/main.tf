resource "azurerm_application_gateway" "appgw" {
  name                = var.appgw_name
  location            = var.location
  resource_group_name = var.rg_name
  sku {
    name     = "Standard_v2"
    tier     = "Standard_v2"
    capacity = 1
  }

  gateway_ip_configuration {
    name      = "appgw-ip-config"
    subnet_id = data.azurerm_subnet.appgw_sub.id
  }

  frontend_port {
    name = var.frontend_port_name   # "frontendPort"
    port = 80
  }

  frontend_ip_configuration {
    name                 = var.frontend_ip_configuration_name   # "frontendIP"
    public_ip_address_id = data.azurerm_public_ip.appgw_pip.id
  }

#   backend_address_pool {
#     name = "backendPool"
#     backend_addresses {
#       ip_address = azurerm_network_interface.nic.private_ip_address
#     }
#   }


 backend_address_pool {
  name = var.backend_address_pool_name  #"backendPool"

  backend_addresses {
    ip_address = azurerm_network_interface.nic1.private_ip_address
  }
  backend_addresses {
    ip_address = azurerm_network_interface.nic2.private_ip_address
  }
  backend_addresses {
    ip_address = azurerm_network_interface.nic3.private_ip_address
  }
}

  backend_http_settings {
    name                  = var.http_setting_name   #  "httpSettings"
    cookie_based_affinity = "Disabled"
    port                  = 80
    protocol              = "Http"
    request_timeout       = 30
  }

  http_listener {
    name                           = var.http_listener_name   #  "httpListener"
    frontend_ip_configuration_name =  var.frontend_ip_configuration_name 
    frontend_port_name             =  var.frontend_port_name
    protocol                       = "Http"
  }

  request_routing_rule {
    name                       = var.request_routing_rule_name    #  "rule1"
    rule_type                  = "Basic"
    http_listener_name         = var.http_listener_name 
    backend_address_pool_name  = var.backend_address_pool_name
    backend_http_settings_name = var.http_setting_name 
  }
}
