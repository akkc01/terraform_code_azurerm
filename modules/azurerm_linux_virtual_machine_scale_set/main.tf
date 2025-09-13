resource "azurerm_linux_virtual_machine_scale_set" "vmss1" {
  name                = var.vmss_name
  resource_group_name = var.rg_name
  location            = var.location
  sku                 = var.sku
  instances           = 1
  admin_username      = var.admin_username
  admin_password      = var.admin_password

  disable_password_authentication = false # Important for password-based login

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
  }

  network_interface {
    name    = "networkinterface1"
    primary = true

    ip_configuration {
      name                                   = "internal"
      primary                                = true
      subnet_id                              = data.azurerm_subnet.vmss_sub.id
      #load_balancer_backend_address_pool_ids = [data.azurerm_lb_backend_address_pool.bepool3.id]
      application_gateway_backend_address_pool_ids = [data.azurerm_application_gateway.appgw.backend_address_pool[0].id, data.azurerm_application_gateway.appgw.backend_address_pool[1].id]
    }
    network_security_group_id = data.azurerm_network_security_group.nsg1.id
  }

  computer_name_prefix   = "vmss"
  overprovision          = true
  single_placement_group = true

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
  - git clone https://github.com/akkc01/akkc_portfolio.git /tmp/devops-site
  - cp -r /tmp/devops-site/* /var/www/html/
  - chown -R www-data:www-data /var/www/html
  - systemctl restart nginx
EOF
  )
}



resource "azurerm_monitor_autoscale_setting" "autoscale1" {
  name                = var.autoscale_name
  resource_group_name = var.rg_name
  location            = var.location
  target_resource_id  = azurerm_linux_virtual_machine_scale_set.vmss1.id
  #enabled             = true

  profile {
    name = "defaultProfile"

    capacity {
      minimum = "1"
      maximum = "5"
      default = "1"
    }

    rule {
      metric_trigger {
        metric_name        = "Percentage CPU"
        metric_resource_id = azurerm_linux_virtual_machine_scale_set.vmss1.id
        time_grain         = "PT1M"
        statistic          = "Average"
        time_window        = "PT5M"
        time_aggregation   = "Average"
        operator           = "GreaterThan"
        threshold          = 70
      }

      scale_action {
        direction = "Increase"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT5M"
      }
    }

    rule {
      metric_trigger {
        metric_name        = "Percentage CPU"
        metric_resource_id = azurerm_linux_virtual_machine_scale_set.vmss1.id
        time_grain         = "PT1M"
        statistic          = "Average"
        time_window        = "PT5M"
        time_aggregation   = "Average"
        operator           = "LessThan"
        threshold          = 20
      }

      scale_action {
        direction = "Decrease"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT5M"
      }
    }
  }

  # notification {
  #   email {
  #     send_to_subscription_administrator    = false
  #     send_to_subscription_co_administrator = false
  #     # custom_emails                         = ["you@example.com"] # Optional
  #   }
  #   # webhook {
  #   #   service_uri = "https://your-webhook-url.com" # Optional
  #   # }
  # }
}


# resource "azurerm_virtual_machine_scale_set_extension" "nginx_install" {
#   name                         = "nginx-install"
#   virtual_machine_scale_set_id = azurerm_linux_virtual_machine_scale_set.vmss1.id
#   publisher                   = "Microsoft.Azure.Extensions"
#   type                        = "CustomScript"
#   type_handler_version        = "2.1"

#   settings = <<SETTINGS
# {
#   "commandToExecute": "sudo apt-get update && sudo apt-get install -y nginx git && git clone https://github.com/akkc01/devopsInsiders_dummy_site.git /tmp/site && sudo rm -rf /var/www/html/* && sudo cp -r /tmp/site/* /var/www/html/ && sudo systemctl restart nginx"
# }
# SETTINGS
# }

