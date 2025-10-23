module "rg" {
  source          = "../modules/azurerm_resource_group"
  resource_groups = var.resource_groups
}

module "storage" {
  source     = "../modules/azurerm_storage_account"
  stgaccount = var.stgaccount
}


module "vnet-subnet" {
  source = "../modules/azurerm_virtual_network"
  vnets = var.vnets
}

module "pips" {
  source = "../modules/azurerm_public_ip"
  pips = var.pips
}

# module "nic" {
#   source = "./modules/nic"
#   nics = {
#     for nic_key, nic_val in var.nics : nic_key => merge(
#       nic_val,
#       {
#         ip_configuration = [
#           for cfg in nic_val.ip_configuration : merge(
#             cfg,
#             {
#               subnet_id = module.vnet.subnet.subnet_ids[0]
#               public_ip_address_id = module.pips.public_ip.public_ip_ids[0]
#             }
#           )
#         ]
#       }
#     )
#   }
# }

# module "nic" {
#   source = "./modules/nic"
#   nics = {
#     for nic_key, nic_val in var.nics : nic_key => merge(
#       nic_val,
#       {
#         ip_configuration = [
#           for cfg in nic_val.ip_configuration : merge(
#             cfg,
#             {
#               subnet_id = lookup(module.vnet.subnet.subnet_ids, nic_key, null),     # subnet id map se key se access
#               public_ip_address_id = lookup(module.pips.public_ip_ids, nic_key, null) # public ip id map se key se access
#             }
#           )
#         ]
#       }
#     )
#   }
# }


module "nics" {
  source = "../modules/azurerm_network_interface"

nics = {
  for nic_key, nic_val in var.nics : nic_key => merge(
    nic_val,
    {
      ip_configuration = [
        for ip_cfg in nic_val.ip_configuration : merge(
          ip_cfg,
          {
            subnet_id           = lookup(module.vnet-subnet.subnet_ids, nic_val.subnet_key, null)
            public_ip_address_id = lookup(module.pips.public_ip_ids, nic_val.pip_key, null)
          }
        )
      ]
    }
  )
}
}

