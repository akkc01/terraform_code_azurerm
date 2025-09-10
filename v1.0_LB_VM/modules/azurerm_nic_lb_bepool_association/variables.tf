
variable "vm1_nic_name" {
  description = "The name of the Network Interface"
  type        = string
}

variable "vm2_nic_name" {
  description = "The name of the Network Interface"
  type        = string
}

variable "rg_name" {
  description = "The name of the resource group"
  type        = string
}

variable "backend_pool_name" {
  description = "The name of the Backend Address Pool"
  type        = string
}

variable "lb_name" {
  description = "The name of the Load Balancer"
  type        = string
}   

variable "ip_configuration_name" {
  description = "The name of the IP configuration on the NIC"
  type        = string
  
}