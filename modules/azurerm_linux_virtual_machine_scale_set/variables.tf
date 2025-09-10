variable "vmss_name" {
  description = "The name of the Virtual Machine Scale Set"
  type        = string
  
}

variable "rg_name" {
  description = "The name of the Resource Group"
  type        = string

}

variable "location" {
  description = "The location where the resources will be created"
  type        = string

}

variable "sku" {
  description = "The SKU of the Virtual Machine Scale Set"
  type        = string

}

variable "admin_username" {
  description = "The admin username for the Virtual Machine Scale Set"
  type        = string

}

variable "admin_password" {
  description = "The admin password for the Virtual Machine Scale Set"
  type        = string

}

variable "vnet_name" {
  description = "The name of the Virtual Network"
  type        = string
  
}
variable "vmss_sub7" {
  description = "The name of the Subnet for VMSS"
  type        = string

}

variable "autoscale_name" {
  description = "The name of the Autoscale Setting"
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

variable "nsg_name" {
  description = "The name of the Network Security Group"
  type        = string
  
}