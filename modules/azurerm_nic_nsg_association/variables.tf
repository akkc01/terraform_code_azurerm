variable "nsg_name" {
  description = "The name of the Network Security Group"
  type        = string
  
}

variable "bastion_nic_name" {
  description = "The name of the Network Interface"
  type        = string
  
}
variable "rg_name" {
  description = "The name of the resource group in which the Network Interface and Network Security Group are located"
  type        = string
  
}

variable "lb_nic_name" {
  description = "The name of the load balancer Network Interface"
  type        = string
  
}