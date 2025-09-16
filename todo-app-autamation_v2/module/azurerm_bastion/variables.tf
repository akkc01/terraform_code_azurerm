variable "bastion_name" {
  description = "The name of the Bastion Host."
  type        = string
  default     = "bastion-host"
}

variable "location" {
  description = "The Azure Region where the Bastion Host should exist."
  type        = string
  default     = "centralindia"
}

variable "rg_name" {
  description = "The name of the Resource Group where the Bastion Host should exist."
  type        = string
  default     = "varddha-rg001"
}

variable "bastion_subnet_id" {
  description = "The ID of the Azure Bastion Subnet."
  type        = string
}

variable "bastion_public_ip_id" {
  description = "The ID of the Public IP Address associated with the Bastion Host."
  type        = string
}
