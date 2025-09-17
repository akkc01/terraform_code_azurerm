resource "azurerm_application_gateway" "appgw" {
  name                = var.appgw_name
  location            = var.location
  resource_group_name = var.rg_name
  sku {
    name = "Standard_v2"
    tier = "Standard_v2"
    # capacity field is not needed with autoscaling
  }

  # Matlab: Jitni zyada traffic aayegi, utne zyada App Gateway instances banenge
  autoscale_configuration {
    min_capacity = 1
    max_capacity = 2
  }

  gateway_ip_configuration {
    name      = "appgw-ip-config"
    subnet_id = data.azurerm_subnet.appgw_sub.id
  }

  frontend_port {
    name = var.frontend_port_name 
    port = 80
  }

 frontend_port {
    name = httpsport443 
    port = 443
  }

  frontend_ip_configuration {
    name                 = var.frontend_ip_configuration_name 
    public_ip_address_id = data.azurerm_public_ip.appgw_pip.id
  }

  backend_address_pool {
    name         = var.backend_address_pool_name1 
     # address ya VMSS id yahan specify karni padegi (agar dynamic ho to via backend_address)
  }

  backend_http_settings {
    name                                = var.http_setting_name1
    protocol                            = "Http"
    port                                = 80
    cookie_based_affinity               = "Enable"
    request_timeout                     = 30
  }

  backend_http_settings {
    name                                = "httpsSetting11"
    protocol                            = "Https"
    port                                = 443
    cookie_based_affinity               = "Enable"
    request_timeout                     = 30
  }

  http_listener {
    name                           = var.http_listener_name1 
    frontend_ip_configuration_name = var.frontend_ip_configuration_name
    frontend_port_name             = var.frontend_port_name
    protocol                       = "Http"
    #host_name                      = "site1.example.com"  # 👈 Yeh multi-site banata hai
  }

    http_listener {
    name                           = "listener_https" 
    frontend_ip_configuration_name = var.frontend_ip_configuration_name
    frontend_port_name             = var.frontend_port_name
    protocol                       = "Https"
    #host_name                      = "site1.example.com"  # 👈 Yeh multi-site banata hai
    ssl_certificate_name           = "myssl-cert-https"
  }

request_routing_rule {
  name                       = var.request_routing_rule_name1
  rule_type                  = "Basic"
  http_listener_name         = var.http_listener_name1
  backend_address_pool_name  = var.backend_address_pool_name1
  backend_http_settings_name = var.http_setting_name1
  priority                   = 10  
}

request_routing_rule {
  name                       = "httpsrrrule"
  rule_type                  = "Basic"
  http_listener_name         = "listener_https" 
  backend_address_pool_name  = var.backend_address_pool_name1
  backend_http_settings_name =  "httpsSetting11"
  priority                   = 9  
}

  ssl_certificate {
    name     = "myssl-cert-https"
    data     = filebase64("C:/Users/AKKC/Desktop/Shell_Scripting/mycert.pfx")  # 👈 Yahan aapka .pfx file ka path aayega
    password = var.ssl_cert_password                        # 👈 PFX file ka password
  }

}