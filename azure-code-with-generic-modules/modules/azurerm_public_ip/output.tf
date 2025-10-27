output "public_ip_ids" {
  value = {
    for pip_key, pip_resource in azurerm_public_ip.pip : pip_key => pip_resource.id
  }
}
