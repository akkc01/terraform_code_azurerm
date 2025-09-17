
resource "random_string" "azurerm_traffic_manager_profile_name" {
  length  = 25
  upper   = false
  numeric = false
  special = false
}

resource "random_string" "azurerm_traffic_manager_profile_dns_config_relative_name" {
  length  = 10
  upper   = false
  numeric = false
  special = false
}

resource "azurerm_traffic_manager_profile" "profile" {
  name                   = random_string.azurerm_traffic_manager_profile_name.result
  resource_group_name    = var.rg_name
  traffic_routing_method = "Performance"

  dns_config {
    relative_name = "theakkc-tm"
    ttl           = 30
  }

  monitor_config {
    protocol                    = "HTTP"
    port                        = 80
    path                        = "/"
    expected_status_code_ranges = ["200-202", "301-302"]
  }

  #   monitor_config {
  #   protocol                    = "HTTPS"
  #   port                        = 443
  #   path                        = "/"
  #   expected_status_code_ranges = ["200-202", "301-302"]
  # }
}

resource "azurerm_traffic_manager_azure_endpoint" "endpoint1" {
  profile_id        = azurerm_traffic_manager_profile.profile.id
  name              = "endpoint1"
  #target            = "www.contoso.com"
  target_resource_id  = var.appgw_pip1
  weight            = 50
}

resource "azurerm_traffic_manager_azure_endpoint" "endpoint2" {
  profile_id        = azurerm_traffic_manager_profile.profile.id
  name              = "endpoint2"
  #target            = "www.contoso.com"
  target_resource_id  = var.appgw_pip2
  weight            = 50
}