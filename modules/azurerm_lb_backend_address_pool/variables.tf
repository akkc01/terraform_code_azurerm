variable "lb_name" {
  description = "The name of the Load Balancer"
  type        = string
  
}

variable "rg_name" {
  description = "The name of the resource group where the Load Balancer is located"
  type        = string
  
}

variable "backend_pool_name" {
  description = "The name of the Backend Address Pool"
  type        = string
  
}

variable "vnet_name" {
  description = "The name of the Virtual Network where the Backend Address Pool is located"
  type        = string

}