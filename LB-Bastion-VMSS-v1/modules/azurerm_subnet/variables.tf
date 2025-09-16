
variable "subnet1" {
  description = "The name of the subnet"
  type        = string  
  
}

variable "subnet1_prefixes" {
  description = "The address prefixes to use for the subnet"
  type        = list(string)        
  
}

variable "vnet_name" {
  description = "The name of the virtual network"
  type        = string
  
}

variable "rg_name" {
  description = "The name of the resource group"
  type        = string
  
}


variable "subnet2" {
  description = "The name of the subnet"
  type        = string  
  
}

variable "subnet2_prefixes" {
  description = "The address prefixes to use for the subnet"
  type        = list(string)        
  
}

variable "subnet3" {
  description = "The name of the subnet for Azure Bastion"
  type        = string
  default     = "AzureBastionSubnet"
  
}
variable "subnet3_prefixes" {
  description = "The address prefixes for the subnet for Azure Bastion"
  type        = list(string)
   
}


variable "location" {
  description = "The Azure region where the resources will be created"
  type        = string
  
}