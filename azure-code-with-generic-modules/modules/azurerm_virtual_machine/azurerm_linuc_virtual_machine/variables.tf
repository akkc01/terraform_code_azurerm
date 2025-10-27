variable "virtual_machines" {
  description = "Map of Linux Virtual Machines to create."
  type = map(object({
    name                            = string
    resource_group_name             = string
    location                        = string
    rg_key                          = string
    nic_key                         = string
    size                            = string
    admin_username                  = string
    disable_password_authentication = optional(bool, true)
    tags                            = optional(map(string))
    zone                            = optional(string)
    encryption_at_host_enabled      = optional(bool, false)
    priority                        = optional(string, "Regular")
    eviction_policy                 = optional(string)
    provision_vm_agent              = optional(bool, true)
    allow_extension_operations      = optional(bool, true)
    admin_password                  = optional(string)
    network_interface_ids           = optional(list(string), [])

    admin_ssh_keys = optional(list(object({
      username   = string
      public_key = string
    })))


    os_disk = object({
      name                         = optional(string, null)
      caching                      = optional(string, "ReadWrite")
      os_disk_storage_account_type = optional(string, "Standard_LRS")
      disk_size_gb                 = optional(number, null)
    })
    source_image_reference = optional(object({
      publisher = string
      offer     = string
      sku       = string
      version   = string
    }))

    boot_diagnostics = optional(object({
      storage_account_uri = optional(string)
    }))

    identity = optional(object({
      type         = string
      identity_ids = optional(list(string))
    }))

  }))
}


variable "rg_names" {
  description = "Map of RG names from RG module"
  type        = map(string)
}
