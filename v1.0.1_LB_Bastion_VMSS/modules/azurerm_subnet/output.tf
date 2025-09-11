output "subnet1" {
  value = azurerm_subnet.sub1.name
}

output "subnet2" {
  value = azurerm_subnet.sub2.name
}

output "bastion_sub_id" {
  value = azurerm_subnet.sub3.id
}