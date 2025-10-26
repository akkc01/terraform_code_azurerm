# output "resource_group_names" {
#   description = "List of all created Resource Group names"
#   value       = [for rg in azurerm_resource_group.rg : rg.name]
# }

output "names" {
  value = { for k, rg in azurerm_resource_group.rg : k => rg.name }
}

output "locations" {
  value = { for k, rg in azurerm_resource_group.rg : k => rg.location }
}