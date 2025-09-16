resource "azurerm_lb_rule" "lbr1" {
  loadbalancer_id                = var.lb_id
  backend_address_pool_ids       = data.azurerm_lb_backend_address_pool.bep1.id != "" ? [data.azurerm_lb_backend_address_pool.bep1.id] : [var.backend_address_pool_id]
  name                           = var.lb_rule_name
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = var.frontend_pool_ip_name
}

