output "nic_ids" {
  description = "IDs of all created network interfaces"
  value       = { for k, nic in azurerm_network_interface.nic : k => nic.id }
}
