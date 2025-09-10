resource "azurerm_key_vault_secret" "example" {
  key_vault_id = azurerm_key_vault.example.id
  name         = "secret-sauce"
  value        = "szechuan"

}
