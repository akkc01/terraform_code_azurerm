variable "vm_name" {
  description = "The name of the virtual machine"
  type        = string
  
}

variable "rg_name" {
  description = "The name of the resource group"
  type        = string
  
}

variable "location" {
  description = "The location of the virtual machine"
  type        = string
  default     = "West Europe"
  
}

variable "vm_size" {
  description = "The size of the virtual machine"
  type        = string
  default     = "Standard_F2"
  
}

variable "vm_nic_name" {
  description = "The name of the VM network interface"
  type        = string
  
}

variable "kv_name" {}
variable "vmuser" {}
variable "vmpass" {}