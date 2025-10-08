resource "azurerm_resource_group" "name" {
  name     = var.resource_group_name
  location = var.location
  tags     = var.tags


  # lifecycle {
  #   create_before_destroy = true
  #   prevent_destroy = true
  #  ignore_changes        = [tags]
  # }
}