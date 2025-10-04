output "subnet_names" {
  value = [for s in var.subnets : s.subnet]
}
