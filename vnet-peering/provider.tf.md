```
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.23.0"
    }
  }
}

provider "azurerm" {
  # Configuration options
  features {}
  subscription_id = "000000000000000000000000000000000000"
  client_id       = "000000000000000000000000000000000000"
  client_secret   = var.client_secret
  tenant_id       = "000000000000000000000000000000000000"
}

```
