variable "lb_id" {
  description = "The ID of the Load Balancer"
  type        = string
  
}

variable "backend_address_pool_id" {
  description = "The ID of the Backend Address Pool"
  type        = string
  
}

variable "lb_rule_name" {
  description = "The name of the Load Balancer Rule"
  type        = string
  default     = "HTTPRule"
  
}

variable "frontend_pool_ip_name" {
  description = "The name of the Frontend IP Configuration"
  type        = string
  default     = "PublicIPAddress"
  
}