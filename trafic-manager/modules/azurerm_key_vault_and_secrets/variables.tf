variable "rg_name" {
  description = "The name of the resource group"
  type        = string
  
}

variable "location" {
  description = "The location of the resource group"
  type        = string
  
}

variable "kv_name" {
  description = "The name of the Key Vault"
  type        = string
  
}

variable "vm_secrets" {
  description = "Map of VM names to secret names"
  type = map(object({
    secret_name = string
    secret_pass = string
  }))
}
