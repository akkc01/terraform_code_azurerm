output "subnet_names" {
  value = [for s in var.subnets : s.subnet]
}

# output "subnet_ids" {
#   value = [for s in var.subnets : s.id]
# }


output "subnet_ids" {
  value = [for s in values(var.subnets) : s.id]
}