variable "health_probe_name" {
  description = "The name of the load balancer health probe."
  type        = string
  default     = "http-probe"
  
}

variable "lb_name" {
  description = "The name of the Load Balancer."
  type        = string
}

variable "rg_name" {
  description = "The name of the Resource Group in which the Load Balancer exists."
  type        = string
  
}