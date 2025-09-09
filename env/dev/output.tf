
output "subnet" {
  value = "Your first subnet is: - ${module.subnet.subnet1}, Your second subnet is: - ${module.subnet.subnet2}"
}

output "LoadBalencer_PIP" {
  #value = azurerm_public_ip.lb_pip.ip_address
  value = "Load Balencer IP is: - ${module.pip.LoadBalencer_PIP}"
}

