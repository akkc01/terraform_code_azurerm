variable "vms" {
  description = "Map of all Windows VMs to deploy"
  type = map(object({
    # Required
    size                         = string
    admin_username               = string
    admin_password               = string
    subnet_id                    = string

    # Optional OS Disk config
    os_disk_storage_account_type = optional(string, "Premium_LRS")
    # Optional flags and settings
    enable_automatic_updates   = optional(bool, true)
    provision_vm_agent         = optional(bool, true)
    allow_extension_operations = optional(bool, true)
    timezone                   = optional(string, "India Standard Time")
    identity_type              = optional(string, "SystemAssigned")
    boot_diagnostics_storage_uri = optional(string)
    tags                       = optional(map(string), {})

    # Optional Image config
    image = optional(object({
      publisher = string
      offer     = string
      sku       = string
      version   = string
    }))


  }))
}