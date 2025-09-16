variable "lb_name" {
  description = "The name of the Load Balancer"
  type        = string
  
}

variable "rg_name" {
  description = "The name of the resource group"
  type        = string
  
}

variable "health_probe_name" {
  description = "The name of the Health Probe"
  type        = string
  default     = "HealthProbe1"
  
}
