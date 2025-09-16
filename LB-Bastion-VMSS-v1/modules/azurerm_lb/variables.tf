variable "lb_name" {
  description = "The name of the Load Balancer"
  type        = string
  
}

variable "location" {
  description = "The location of the Load Balancer"
  type        = string
 
}

variable "rg_name" {
  description = "The name of the resource group"
  type        = string
  
}

variable "frontend_pool_ip_name" {
  description = "The name of the Frontend IP Configuration"
  type        = string
  default     = "PublicIPAddress"
  
}


variable "sku" {
  description = "The SKU of the Load Balancer. Possible values are 'Basic' and 'Standard'"
  type        = string
  default     = "Standard"
  
}

variable "lb_pip2_name" {
  description = "The name of the Public IP for the Load Balancer"
  type        = string
  
}