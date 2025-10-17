terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "> 3.0"
    }
  }
}

provider "azurerm" {
    features {}
  # Configuration options
  subscription_id = var.subscription_id
}