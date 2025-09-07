
resource "azurerm_lb_rule" "lbr" {
  loadbalancer_id                = data.azurerm_lb.lb.id
  backend_address_pool_ids       = [data.azurerm_lb_backend_address_pool.bepool.id]
  name                           = var.lb_rule_name
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = var.frontend_ip_name
  probe_id                       = var.lbprobe_id
  idle_timeout_in_minutes        = 4

}

