resource "azurerm_windows_virtual_machine" "vm" {
  for_each = var.vms

  name                = each.key
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.global_config.location
  size                = each.value.size
  admin_username      = each.value.admin_username
  admin_password      = each.value.admin_password
  network_interface_ids = [azurerm_network_interface.nic[each.key].id]

  os_disk {
    name                 = "${each.key}-osdisk"
    caching              = "ReadWrite"
    storage_account_type = each.value.os_disk_storage_account_type
  }

  source_image_reference {
    publisher = each.value.image.publisher
    offer     = each.value.image.offer
    sku       = each.value.image.sku
    version   = each.value.image.version
  }

  computer_name             = each.key
  enable_automatic_updates  = try(each.value.enable_automatic_updates, true)
  provision_vm_agent        = try(each.value.provision_vm_agent, true)
  allow_extension_operations = try(each.value.allow_extension_operations, true)
  timezone                  = try(each.value.timezone, "India Standard Time")

  boot_diagnostics {
    storage_account_uri = try(each.value.boot_diagnostics_storage_uri, null)
  }

  identity {
    type = try(each.value.identity_type, "SystemAssigned")
  }

  tags = merge(
    var.global_config.tags,
    try(each.value.tags, {})
  )
}
