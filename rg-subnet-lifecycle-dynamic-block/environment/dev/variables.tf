variable "resource_group_name" {}
variable "location" {}
variable "virtual_network_name" {}
variable "address_space" {}
variable "subnets" {}
variable "subscription_id" {}
variable "security_rules" {}
variable "nsg_name" {}

variable "tags" {
  type    = object({
    env         = string
    owner       = string
    cost_center = string
  })
}