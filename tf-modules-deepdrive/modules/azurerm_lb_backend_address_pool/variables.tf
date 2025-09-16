variable "lb_name" {
  description = "The name of the Load Balancer"
  type        = string
  
}

variable "rg_name" {
  description = "The name of the resource group where the Load Balancer is located"
  type        = string
  
}

variable "backendpool_name" {
  description = "The name of the Backend Address Pool"
  type        = string
  
}