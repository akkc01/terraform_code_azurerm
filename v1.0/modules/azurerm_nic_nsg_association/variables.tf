variable "nsg_name" {
  description = "The name of the Network Security Group"
  type        = string
  
}

variable "rg_name" {
  description = "The name of the resource group in which the Network Interface and Network Security Group are located"
  type        = string
  
}


variable "vm1_nic_name" {
  description = "The name of the VM1 Network Interface"
  type        = string
  
}

variable "vm2_nic_name" {
  description = "The name of the VM2 Network Interface"
  type        = string
  
}

variable "vnet_name" {
  description = "The name of the virtual network where the bastion subnet is located"
  type        = string
  
}
variable "subnet_name" {}