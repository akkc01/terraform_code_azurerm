module "rg" {
  source          = "../modules/azurerm_resource_group"
  resource_groups = var.resource_groups
}

module "storage" {
  depends_on = [ module.rg ]
  source     = "../modules/azurerm_storage_account"
  stgaccount = var.stgaccount
}

module "vnet-subnet" {
  depends_on = [ module.rg ]
  source = "../modules/azurerm_virtual_network"
  vnets = var.vnets
}

module "pips" {
  depends_on = [ module.rg ]
  source = "../modules/azurerm_public_ip"
  pips = var.pips
}

module "nics" {
  depends_on = [ module.rg, module.vnet-subnet, module.pips ]
  source = "../modules/azurerm_network_interface"

  nics = {
    for nic_key, nic_val in var.nics : nic_key => merge(
      nic_val,
      {
        ip_configuration = [
          for ip_cfg in nic_val.ip_configuration : merge(
            ip_cfg,
            {
              subnet_id            = lookup(module.vnet-subnet.subnet_ids[ip_cfg.vnet_key][ip_cfg.subnet_key])
              public_ip_address_id = lookup(module.pips.public_ip_ids, ip_cfg.pip_key)
            }
          )
        ]
      }
    )
  }
}

module "nsg_rules" {
  depends_on = [ module.rg ]
  source = "../modules/azurerm_network_security_rule"
  nsg = var.nsg
}

