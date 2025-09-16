variable "nsg_name" {
  description = "The name of the Network Security Group"
  type        = string
  
}

variable "rg_name" {
  description = "The name of the resource group in which the Network Interface and Network Security Group are located"
  type        = string
  
}

variable "vnet_name" {
  description = "The name of the virtual network where the bastion subnet is located"
  type        = string
  
}
variable "appgw_subnet_name" {}