variable "nsg_name" {
  description = "The name of the Network Security Group"
  type        = string
  
}

variable "location" {
  description = "The location of the Network Security Group"
  type        = string
  default     = "West Europe"
  
}

variable "rg_name" {
  description = "The name of the resource group"
  type        = string
  
}