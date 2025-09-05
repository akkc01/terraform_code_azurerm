
resource "azurerm_lb_probe" "lbprobe1" {
  loadbalancer_id = data.azurerm_lb.lb3.id
  name            = var.health_probe_name
  port            = 80
  protocol        = "Tcp"
  interval_in_seconds = 5
}

