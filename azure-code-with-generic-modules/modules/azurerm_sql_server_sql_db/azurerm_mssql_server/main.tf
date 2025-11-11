data "azurerm_client_config" "current" {}

# resource "azurerm_user_assigned_identity" "example" {
#   name                = "example-admin"
#   location            = azurerm_resource_group.example.location
#   resource_group_name = azurerm_resource_group.example.name
# }

resource "azurerm_mssql_server" "example" {
  name                         = "example-resource"
  resource_group_name          = azurerm_resource_group.example.name
  location                     = azurerm_resource_group.example.location
  version                      = "12.0"
  administrator_login          = "Example-Administrator"
  administrator_login_password = "Example_Password!"
  minimum_tls_version          = "1.2"

  # azuread_administrator {
  #   login_username = azurerm_user_assigned_identity.example.name
  #   object_id      = azurerm_user_assigned_identity.example.principal_id
  # }

  # identity {
  #   type         = "UserAssigned"
  #   identity_ids = [azurerm_user_assigned_identity.example.id]
  # }

  # primary_user_assigned_identity_id            = azurerm_user_assigned_identity.example.id
  # transparent_data_encryption_key_vault_key_id = azurerm_key_vault_key.example.id
}
