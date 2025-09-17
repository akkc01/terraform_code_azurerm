# output "LoadBalencer_PIP" {
#   value = azurerm_public_ip.lb_pip.ip_address
# }

output "appgw_pip" {
  value = azurerm_public_ip.appgw_pip.ip_address
}

output "appgw_pip_id" {
  value = azurerm_public_ip.appgw_pip.id
}