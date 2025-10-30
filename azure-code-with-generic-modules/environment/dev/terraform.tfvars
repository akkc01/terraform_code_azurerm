subscription_id = "b398fea1-2f06-4948-924a-121d4ed265b0"

resource_groups = {
  rg1 = {
    name       = "project-jarvis"
    location   = "westus"
    managed_by = "tony_stark"
    tags = {
      environment = "prod"
      project     = "jarvis"
      owner       = "team_stark"
      phase       = "final"
    }
  }

  rg2 = {
    name       = "project-mark42"
    location   = "EastUS"
    managed_by = "tonystark"
    tags = {
      environment = "dev"
      project     = "mark42"
      owner       = "tonystark"
      phase       = "initial"
    }
  }
}

stgaccount = {
  stgacc1 = {
    name                     = "stgaccwestus001"
    resource_group_name      = ""
    rg_key                   = "rg1"
    location                 = "eastus"
    account_tier             = "Standard"
    account_replication_type = "LRS"
    tags = {
      environment = "dev"
      project     = "jarvis"
      owner       = "team_stark"
    }
    access_tier = "Hot"
  }
}

vnets = {
  vnet1 = {
    name                = "vnet1"
    resource_group_name = ""
    rg_key              = "rg1"
    location            = "West Europe"
    address_space       = ["192.168.0.0/21"]
    subnet = {

      #Key aur Name same rakho for mapping purpose in nic module
      subnet1 = {
        name             = "subnet1"
        address_prefixes = ["192.168.1.0/24"]
      }
    }
  }
  vnet2 = {
    name                = "vnet1"
    resource_group_name = ""
    rg_key              = "rg2"
    location            = "EastUS"
    address_space       = ["10.10.0.0/16"]
    subnet = {
      subnet1 = {
        name             = "subnet1"
        address_prefixes = ["10.10.1.0/24"]
      }
    }
  }
}

pips = {
  pip1 = {
    name                = "pip1"
    location            = "West Europe"
    resource_group_name = ""
    rg_key              = "rg1"
    allocation_method   = "Static"
    sku                 = "Standard"
    tags = {
      environment = "dev"
      project     = "jarvis"
      owner       = "team_stark"
    }
  }
}

nics = {
  nic1 = {
    name                = "nic1"
    location            = "West Europe"
    resource_group_name = ""
    rg_key              = "rg1"
    ip_configuration = [
      {
        name                          = "ipconfig1"
        private_ip_address_allocation = "Dynamic"
        subnet_key                    = "subnet1"
        vnet_key                      = "vnet1"
        pip_key                       = "pip1"
      }
    ]

    tags = {
      environment = "dev"
      project     = "jarvis"
      owner       = "team_stark"
    }
  }
  nic2 = {
    name                = "nic1"
    resource_group_name = ""
    rg_key              = "rg2"
    location            = "EastUS"
    ip_configuration = [
      {
        name                          = "ipconfig1"
        private_ip_address_allocation = "Dynamic"
        subnet_key                    = "subnet121"
        vnet_key                      = "vnet2"
        # pip_key                       = "pip2"
      }
    ]

    tags = {
      environment = "prod"
      project     = "vision"
      owner       = "team_rogers"
    }
  }
}

nsg = {
  nsg1 = {
    nsg_name            = "nsg1"
    location            = "West Europe"
    resource_group_name = ""
    rg_key              = "rg1"
    tags = {
      environment = "dev"
      project     = "jarvis"
      owner       = "team_stark"
    }
    security_rule = [
      {
        name                    = "allow_ssh"
        priority                = 100
        direction               = "Inbound"
        access                  = "Allow"
        protocol                = "Tcp"
        source_port_range       = "*"                       # keep one side as single (usually *)
        # destination_port_range  = "22"
        #source_port_ranges      = ["80", "443"]            # Source ports
        destination_port_ranges = ["8080", "8443", "9000"]  # Destination ports

        source_address_prefix      = "*"
        destination_address_prefix = "*"
        description                = "Allow SSH inbound traffic"
      },
      {
        name                       = "deny_all_outbound"
        priority                   = 200
        direction                  = "Outbound"
        access                     = "Deny"
        protocol                   = "*"
        source_port_range          = "*"
        destination_port_range     = "*"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
        description                = "Deny all outbound traffic"
      }
    ]

  }
  nsg2 = {
    nsg_name            = "nsg1"
    resource_group_name = ""
    rg_key              = "rg2"
    location            = "EastUS"
    tags = {
      environment = "dev"
      project     = "jarvis"
      owner       = "team_stark"
    }
    security_rule = [
      {
        name                       = "allow_ssh"
        priority                   = 100
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
        description                = "Allow SSH inbound traffic"
      },
      {
        name                       = "deny_all_outbound"
        priority                   = 200
        direction                  = "Outbound"
        access                     = "Deny"
        protocol                   = "*"
        source_port_range          = "*"
        destination_port_range     = "*"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
        description                = "Deny all outbound traffic"
      }
    ]

  }

}

virtual_machines = {
  vm1 = {
    name                            = "linux-vm-01"
    resource_group_name             = ""
    rg_key                          = "rg1"
    nic_key                         = "nic1"
    location                        = "West Europe"
    size                            = "Standard_B2s"
    admin_username                  = "azureuser"
    admin_password                  = "ChangeMe123!"
    disable_password_authentication = false

    # network_interface_ids = [
    #   "/subscriptions/xxxx/resourceGroups/rg-example/providers/Microsoft.Network/networkInterfaces/nic-01"
    # ]

    # admin_ssh_keys = [
    #   {
    #     username   = "azureuser"-7
    #     public_key = file("~/.ssh/id_rsa.pub")
    #   }
    # ]

    os_disk = {
      name                 = "linux-vm-01-osdisk"
      caching              = "ReadWrite"
      storage_account_type = "Standard_LRS"
      disk_size_gb         = 30
    }


    source_image_reference = {
      publisher = "Canonical"
      offer     = "0001-com-ubuntu-server-jammy"
      sku       = "22_04-lts"
      version   = "latest"
    }

    tags = {
      environment = "dev"
      owner       = "team-alpha"
    }
  }

  vm2 = {
    name                            = "linux-vm-02"
    resource_group_name             = ""
    rg_key                          = "rg2"
    nic_key                         = "nic2"
    location                        = "EastUS"
    size                            = "Standard_F2"
    admin_username                  = "ubuntu"
    disable_password_authentication = false
    admin_password                  = "ChangeMe123!"
    encryption_at_host_enabled      = false
    priority                        = "Spot"
    eviction_policy                 = "Deallocate"
    # network_interface_ids = [
    #   "/subscriptions/xxxx/resourceGroups/rg-example/providers/Microsoft.Network/networkInterfaces/nic-02"
    # ]
    os_disk = {
      name                 = "linux-vm-01-osdisk"
      caching              = "ReadWrite"
      storage_account_type = "Standard_LRS"
      disk_size_gb         = 30
    }

    source_image_reference = {
      publisher = "Canonical"
      offer     = "0001-com-ubuntu-server-jammy"
      sku       = "22_04-lts"
      version   = "latest"
    }

    tags = {
      environment = "dev"
      owner       = "team-alpha"
    }
  }
}

nic_nsg_map = {
  association1 = {
    nic_key = "nic1"
    nsg_key = "nsg1"
  }
  association2 = {
    nic_key = "nic2"
    nsg_key = "nsg2"
  }
}
