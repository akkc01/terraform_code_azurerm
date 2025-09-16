variable "lb_name" {
  description = "The name of the Load Balancer"
  type        = string
  
}

variable "rg_name" {
  description = "The name of the resource group"
  type        = string
  
}

variable "frontend_ip_name" {
  description = "The name of the Frontend IP Configuration"
  type        = string
  default     = "PublicIPAddress"
  
}

variable "backend_pool_name" {
  description = "The name of the Backend Address Pool"
  type        = string
  default     = "BackendPool1"
  
}

variable "lb_rule_name" {
  description = "The name of the Load Balancer Rule"
  type        = string
  default     = "HTTPRule1"

}


variable "lbprobe_id" {
  
}

