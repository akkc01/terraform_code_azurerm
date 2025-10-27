output "resource_groups" {
  value = module.rg.names
  
}

output "storage_accounts" {
  value = module.storage.storage_account_names
}

output "debug_subnet_ids" {
  value = module.vnet-subnet.subnet_ids
}
output "public_ip_addresses" {
  value = module.pips.public_ip_ids
}


output "all_nic_ids" {
  description = "All NIC IDs from the NIC module"
  value       = module.nics.nic_ids
}
