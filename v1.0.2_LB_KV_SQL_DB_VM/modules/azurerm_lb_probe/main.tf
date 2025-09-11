
resource "azurerm_lb_probe" "lbprobe" {
  loadbalancer_id     = data.azurerm_lb.lb.id
  name                = var.health_probe_name
  port                = 80
  protocol            = "Tcp"
  interval_in_seconds = 5
}

