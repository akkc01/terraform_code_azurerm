resource "azurerm_lb_rule" "lbr1" {
  loadbalancer_id                = data.azurerm_lb.lb4.id
  backend_address_pool_ids       = [data.azurerm_lb_backend_address_pool.bepool2.id]
  name                           = var.lb_rule_name
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = var.frontend_pool_ip_name
  probe_id                       = var.probe_id
  idle_timeout_in_minutes        = 4

}

