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
 variable "probe_id" {
  description = "The ID of the Health Probe"
  type        = string
   
 }
variable "lb_name" {
  type = string 
  
}

variable "rg_name" {
  type = string 
  
}
variable "backend_pool_name" {
  type = string 
  
}