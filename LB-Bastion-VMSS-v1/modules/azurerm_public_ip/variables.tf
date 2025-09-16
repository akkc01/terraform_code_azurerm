variable "bastion_pip1_name" {
  description = "The name of the Public IP"
  type        = string
  
}

variable "rg_name" {
  description = "The name of the Resource Group in which to create the Public IP"
  type        = string
  
}

variable "location" {
  description = "The Azure region where the Public IP should exist"
  type        = string
  
}

variable "allocation_method" {
  description = "The allocation method of the Public IP. Possible values are Static or Dynamic"
  type        = string
  default     = "Static"
  
}

variable "sku" {
  description = "The SKU of the Public IP. Possible values are Basic or Standard"
  type        = string  
  
}

variable "lb_pip1_name" {
  description = "The name of the Public IP for the Load Balancer"
  type        = string
  
}