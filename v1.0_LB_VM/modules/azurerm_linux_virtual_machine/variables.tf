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
variable "admin_username" {
  description = "The admin username of the virtual machine"
  type        = string
  
}

variable "admin_password" {
  description = "The admin password of the virtual machine"
  type        = string
  
}

variable "vm_nic_name" {
  description = "The name of the VM network interface"
  type        = string
  
}