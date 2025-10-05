output "subnet_names" {
  value = "Subnet Names are: ${join(", ", [for s in var.subnets : s.subnet])}"
}


output "nsg_id" {
  value = "NSG Name is: ${module.nsg.nsg_id}"
}