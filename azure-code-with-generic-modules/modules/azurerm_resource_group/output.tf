output "rg_names" {
  value = [for rg in var.resource_groups : rg.name]
  
}