resource "azurerm_linux_virtual_machine" "lvm1" {
  name                            = var.vm_name
  resource_group_name             = var.rg_name
  location                        = var.location
  size                            = var.vm_size
  admin_username                  = var.admin_username
  admin_password                  = var.admin_password
  disable_password_authentication = false

  network_interface_ids = [data.azurerm_network_interface.vmnic.id]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  custom_data = base64encode(<<EOF
#cloud-config
package_update: true
packages:
  - nginx
  - git

runcmd:
  - systemctl enable nginx
  - systemctl start nginx
  - rm -rf /var/www/html/*
  - git clone https://github.com/akkc01/devopsInsiders_dummy_site.git /tmp/devops-site
  - cp -r /tmp/devops-site/* /var/www/html/
  - chown -R www-data:www-data /var/www/html
  - systemctl restart nginx
EOF
  )
}
