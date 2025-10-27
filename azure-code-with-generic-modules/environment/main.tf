module "rg" {
  source          = "../modules/azurerm_resource_group"
  resource_groups = var.resource_groups
}

module "storage" {
  depends_on = [module.rg]
  source     = "../modules/azurerm_storage_account"
  stgaccount = var.stgaccount
  rg_names   = module.rg.names
}

module "vnet-subnet" {
  depends_on = [module.rg]
  source     = "../modules/azurerm_vnet_subnet"
  vnets      = var.vnets
  rg_names   = module.rg.names
}

module "pips" {
  depends_on = [module.rg]
  source     = "../modules/azurerm_public_ip"
  pips       = var.pips
  rg_names   = module.rg.names
}

module "nics" {
  depends_on = [module.rg, module.vnet-subnet, module.pips]
  source     = "../modules/azurerm_network_interface"
  nics = {
    for nic_key, nic_val in var.nics : nic_key => merge(
      nic_val,
      {
        ip_configuration = [
          for ip_cfg in nic_val.ip_configuration : merge(
            ip_cfg,
            {
              subnet_id            = module.vnet-subnet.subnet_ids[ip_cfg["vnet_key"]][ip_cfg["subnet_key"]]
              public_ip_address_id = try(module.pips.public_ip_ids[ip_cfg["pip_key"]], null)
            }
          )
        ]
      }
    )
  }
  rg_names = module.rg.names
}

module "nsg_rules" {
  depends_on = [module.rg]
  source     = "../modules/azurerm_network_security_rule"
  nsg        = var.nsg
  rg_names   = module.rg.names

}


module "lvm" {
  depends_on = [module.rg, module.nics]
  source     = "../modules/azurerm_virtual_machine/azurerm_linuc_virtual_machine"
  virtual_machines = {
    for vm_key, vm_val in var.virtual_machines : vm_key => merge(
      vm_val,
      {
        network_interface_ids = [
          module.nics.nic_ids[vm_val.nic_key]
        ]
      }
    )
  }
  rg_names = module.rg.names
}
