variable "nic_name" {
  description = "The name of the network interface"
  type        = string
  
}

variable "rg_name" {
  description = "The name of the resource group"
  type        = string
  
}

variable "location" {
  description = "The location of the network interface"
  type        = string
  default     = "West Europe"
  
}

variable "subnet5" {
  description = "The name of the subnet where the NIC will be deployed"
  type        = string
  
}

variable "vnet_name" {
  description = "The name of the virtual network where the subnet is located"
  type        = string
  
}