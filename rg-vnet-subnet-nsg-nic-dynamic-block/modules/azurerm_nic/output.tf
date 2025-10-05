output "subnet_ids" {
  value = [for s in data.azurerm_subnet.subnets : s.id]
}

