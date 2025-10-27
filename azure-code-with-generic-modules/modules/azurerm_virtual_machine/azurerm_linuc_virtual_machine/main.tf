resource "azurerm_linux_virtual_machine" "lvm" {
  for_each = var.virtual_machines

  name                            = each.value.name
  resource_group_name             = var.rg_names[each.value.rg_key]
  location                        = each.value.location
  size                            = each.value.size
  admin_username                  = each.value.admin_username
  disable_password_authentication = each.value.disable_password_authentication
  network_interface_ids           = each.value.network_interface_ids
  # Optional fields
  admin_password             = try(each.value.admin_password, null)
  tags                       = try(each.value.tags, {})
  zone                       = try(each.value.zone, null)
  encryption_at_host_enabled = try(each.value.encryption_at_host_enabled, false)
  priority                   = try(each.value.priority, "Regular")
  eviction_policy            = try(each.value.eviction_policy, null)
  provision_vm_agent         = try(each.value.provision_vm_agent, true)
  allow_extension_operations = try(each.value.allow_extension_operations, true)


  # SSH key block (optional)
  dynamic "admin_ssh_key" {
    for_each = lookup(each.value, "admin_ssh_keys", [])
    content {
      username   = admin_ssh_key.value.username
      public_key = admin_ssh_key.value.public_key
    }
  }

  dynamic "os_disk" {
    for_each = each.value.os_disk != null ? [each.value.os_disk] : []

    content {
      name                 = lookup(os_disk.value, "name", null)
      caching              = lookup(os_disk.value, "caching", "ReadWrite")
      storage_account_type = lookup(os_disk.value, "storage_account_type", "Standard_LRS")
      disk_size_gb         = lookup(os_disk.value, "disk_size_gb", null)
    }
  }

  dynamic "source_image_reference" {
    for_each = each.value.source_image_reference != null ? [each.value.source_image_reference] : []

    content {
      publisher = source_image_reference.value.publisher
      offer     = source_image_reference.value.offer
      sku       = source_image_reference.value.sku
      version   = source_image_reference.value.version
    }
  }

  dynamic "boot_diagnostics" {
    for_each = lookup(each.value, "boot_diagnostics", null) != null ? [each.value.boot_diagnostics] : []
    content {
      storage_account_uri = lookup(boot_diagnostics.value, "storage_account_uri", null)
    }
  }

  dynamic "identity" {
    for_each = lookup(each.value, "identity", null) != null ? [each.value.identity] : []
    content {
      type         = identity.value.type
      identity_ids = lookup(identity.value, "identity_ids", null)
    }
  }
}
