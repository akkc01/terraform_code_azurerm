# variable "bastion_nic_name" {
#   description = "The name of the network interface"
#   type        = string
  
# }

variable "rg_name" {
  description = "The name of the resource group"
  type        = string
  
}

variable "location" {
  description = "The location of the network interface"
  type        = string
  default     = "West Europe"
  
}

variable "bastion_sub5" {
  description = "The name of the subnet where the NIC will be deployed"
  type        = string
  
}
variable "lb_sub6" {
  description = "The name of the subnet where the NIC will be deployed"
  type        = string
  
}

variable "vnet_name" {
  description = "The name of the virtual network where the subnet is located"
  type        = string
  
}

variable "lb_nic_name" {
  description = "The name of the load balancer network interface"
  type        = string
  
}