# variable "resource_group_name" {}
variable "location" {}

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