data "azurerm_client_config" "current" {}


resource "azurerm_key_vault" "kv1" {
  name                        = "dev${var.rg_name}${var.kv_name}${var.location}"
  location                    = var.location
  resource_group_name         = var.rg_name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  sku_name = "standard"

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id


    secret_permissions = [
      "Set",
      "Get",
      "List",

    ]

    storage_permissions = [
      "Get",
    ]
  }
}

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