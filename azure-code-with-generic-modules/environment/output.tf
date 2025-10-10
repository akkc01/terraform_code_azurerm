output "resource_groups" {
  value = module.rg.rg_names
  
}

output "storage_accounts" {
  value = module.storage.storage_account_names
}