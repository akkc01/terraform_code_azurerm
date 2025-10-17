resource "azurerm_resource_group" "rg1" {
  name       = local.rg_name1 # Reuired 
  location   = "eastus"       # Reuired
  managed_by = "terraform"    #optional
}


# moved block ke liye maine isme changes kiya h rg name and local name
resource "azurerm_resource_group" "rg22" {
  name       = local.rg_name    # Reuired 
  location   = local.location   # Reuired
  managed_by = local.managed_by #optional
  tags       = local.tags       # Optional
}


# import block ke liye, ye RG cloud pe bana h mai isko statefile me import kar rha hun
resource "azurerm_resource_group" "rg3" {
  name     = "rg-maneesh"
  location = "eastus"
}

import {
  id = "/subscriptions/b398fea1-2f06-4948-924a-121d4ed265b0/resourceGroups/rg-maneesh"
  to = azurerm_resource_group.rg3
}

moved {
  from = azurerm_resource_group.rg2
  to   = azurerm_resource_group.rg22
}


resource "azurerm_resource_group" "rg4" {
  name     = "rg-maneesh88"
  location = "eastus"
}

resource "azurerm_resource_group" "rg5" {
  name     = "rg-maneesh44"
  location = "eastus"
}
