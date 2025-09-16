resource "azurerm_lb_backend_address_pool" "example" {
  loadbalancer_id = data.azurerm_lb.lb2.id
  name            = var.backendpool_name
}