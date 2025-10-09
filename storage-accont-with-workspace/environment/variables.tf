variable "resource_group_name" {}
variable "location" {}
variable "subscription_id" {}

variable "tags" {
  type    = object({
    env         = string
    owner       = string
    cost_center = string
  })
}

variable "stg_name" {
  
}
variable "account_tier" {
  type    = string
  default = "Standard"
  
}

variable "account_replication_type" {
  type    = string
  default = "LRS"
  
}

variable "access_tier" {
  type    = string
  default = "Hot"
  
}