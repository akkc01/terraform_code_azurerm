resource "azurerm_resource_policy_assignment" "example" {
  name                 = "example-policy-assignment"
  resource_id          = data.azurerm_virtual_network.example.id
  policy_definition_id = data.azurerm_policy_definition.example.id
}