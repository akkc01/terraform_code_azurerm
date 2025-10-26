resource "azurerm_public_ip" "pip" {
  for_each = var.public_ips

  name                      = each.value.pip_name
  resource_group_name = var.rg_names[each.value.rg_key]
  location            = var.rg_locations[each.value.rg_key]
  allocation_method         = each.value.allocation_method

  zones                     = lookup(each.value, "zones", null)
  ddos_protection_mode      = lookup(each.value, "ddos_protection_mode", null)
  ddos_protection_plan_id   = lookup(each.value, "ddos_protection_plan_id", null)
  domain_name_label         = lookup(each.value, "domain_name_label", null)
  domain_name_label_scope   = lookup(each.value, "domain_name_label_scope", null)
  edge_zone                 = lookup(each.value, "edge_zone", null)
  idle_timeout_in_minutes   = lookup(each.value, "idle_timeout_in_minutes", null)
  ip_tags                   = lookup(each.value, "ip_tags", null)
  ip_version                = lookup(each.value, "ip_version", "IPv4")
  public_ip_prefix_id       = lookup(each.value, "public_ip_prefix_id", null)
  reverse_fqdn              = lookup(each.value, "reverse_fqdn", null)
  sku                       = lookup(each.value, "sku", "Standard")
  sku_tier                  = lookup(each.value, "sku_tier", "Regional")
  tags                      = lookup(each.value, "tags", null)
}
