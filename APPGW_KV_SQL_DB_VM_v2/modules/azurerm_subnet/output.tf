output "subnet1" {
  value = azurerm_subnet.sub1.name
}

output "subnet2" {
  value = azurerm_subnet.sub2.name
}

output "subnet4" {
  value = azurerm_subnet.appgw_subnet.name
}