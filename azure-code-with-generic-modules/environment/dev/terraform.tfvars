subscription_id = "c0748677-9808-4356-8816-dc8088c5bb59"

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
    location   = "CanadaCentral"
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
    name                     = "stgaccwestus001007"
    resource_group_name      = ""
    rg_key                   = "rg1"
    location                 = "CanadaCentral"
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
  rg1_vnet1 = {
    name                = "vnet1"
    resource_group_name = ""
    rg_key              = "rg1"
    location            = "West Europe"
    address_space       = ["192.168.0.0/21"]
  }
  rg2_vnet1 = {
    name                = "vnet1"
    resource_group_name = ""
    rg_key              = "rg2"
    location            = "CanadaCentral"
    address_space       = ["10.10.0.0/16"]
    tags = {
      environment = "dev"
      project     = "mark42"
      owner       = "tonystark"
      phase       = "initial"
    }
  }
}

subnets = {
  frontend = {
    subnet_name          = "akkc-frontend-subnet01"
    rg_key               = "rg1"
    resource_group_name  = ""
    virtual_network_name = "vnet1"
    address_prefixes     = ["192.168.3.0/24"]
  }

  backend = {
    subnet_name          = "akkc-backend-subnet01"
    rg_key               = "rg2"
    resource_group_name  = ""
    virtual_network_name = "vnet1"
    address_prefixes     = ["10.10.1.0/24"]
  }
}

pips = {
  rg1_pip1 = {
    pip_name            = "akkc-pip01"
    location            = "WestEurope"
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
  rg2_pip1 = {
    pip_name            = "wvm-akkc-pip01"
    location            = "CanadaCentral"
    resource_group_name = ""
    rg_key              = "rg2"
    allocation_method   = "Static"
    sku                 = "Standard"
    tags = {
      environment = "dev"
      project     = "mark42"
      owner       = "tonystark"
      phase       = "initial"
    }
  }
}

# nics = {
#   nic1 = {
#     name                = "nic1"
#     location            = "West Europe"
#     resource_group_name = ""
#     rg_key              = "rg1"
#     ip_configuration = [
#       {
#         name                          = "ipconfig1"
#         private_ip_address_allocation = "Dynamic"
#         subnet_key                    = "frontend_subnet"
#         vnet_key                      = "vnet1"
#         pip_key                       = "pip1"
#         #        subnet_id                     = " " # Leave empty, will be set in module
#       }
#     ]
#     tags = {
#       environment = "dev"
#       project     = "jarvis"
#       owner       = "team_stark"
#     }
#   }
#   nic2 = {
#     name                = "nic1"
#     resource_group_name = ""
#     rg_key              = "rg2"
#     location            = "CanadaCentral"
#     ip_configuration = [
#       {
#         name                          = "ipconfig1"
#         private_ip_address_allocation = "Dynamic"
#         subnet_key                    = "subnet1"
#         vnet_key                      = "vnet2"
#         # pip_key                       = "pip2"
#         #subnet_key = "frontend_subnet"
#       }
#     ]

#     tags = {
#       environment = "prod"
#       project     = "vision"
#       owner       = "team_rogers"
#     }
#   }

#   nic3 = {
#     name                = "nic2"
#     location            = "West Europe"
#     resource_group_name = ""
#     rg_key              = "rg1"
#     ip_configuration = [
#       {
#         name                          = "ipconfig2"
#         private_ip_address_allocation = "Dynamic"
#         subnet_key                    = "frontend_subnet"
#         vnet_key                      = "vnet1"
#         #pip_key                       = "pip1"
#         #        subnet_id                     = " " # Leave empty, will be set in module
#       }
#     ]

#     tags = {
#       environment = "prod"
#       project     = "vision"
#       owner       = "team_rogers"
#     }
#   }

# }

nics_with_data = {
  nic1 = {
    nic_name            = "akkc-nic01"
    resource_group_name = ""
    rg_key              = "rg1"
    location            = "West Europe"
    pip_name            = "akkc-pip01"
    subnet_name         = "akkc-frontend-subnet01"
    vnet_name           = "vnet1"
    ip_configuration = [{
      name                          = "ipconfig01"
      private_ip_address_allocation = "Dynamic"
    }]
    tags = {
      environment = "dev"
      project     = "jarvis"
      owner       = "team_stark"
    }
  }

  nic2 = {
    nic_name            = "akkc-nic02"
    resource_group_name = ""
    rg_key              = "rg2"
    location            = "CanadaCentral"
    pip_name            = "wvm-akkc-pip01"
    subnet_name         = "akkc-backend-subnet01"
    vnet_name           = "vnet1"
    ip_configuration = [{
      name                          = "ipconfig01"
      private_ip_address_allocation = "Dynamic"
    }]
    tags = {
      environment = "dev"
      project     = "jarvis"
      owner       = "team_stark"
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
        name              = "allow_ssh"
        priority          = 100
        direction         = "Inbound"
        access            = "Allow"
        protocol          = "Tcp"
        source_port_range = "*" # keep one side as single (usually *)
        # destination_port_range  = "22"
        #source_port_ranges      = ["80", "443"]            # Source ports
        destination_port_ranges    = ["8080", "8443", "9000"] # Destination ports
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
      },
      {
        name                       = "allow_ssh1"
        priority                   = 103
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
        description                = "Allow SSH inbound traffic"
      }
    ]

  }
  nsg2 = {
    nsg_name            = "nsg1"
    resource_group_name = ""
    rg_key              = "rg2"
    location            = "CanadaCentral"
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

key_vaults = {
  kv-dev = {
    name                            = "dev-keyvault-777"
    location                        = "westus"
    resource_group_name             = ""
    rg_key                          = "rg1"
    sku_name                        = "standard"
    soft_delete_retention_days      = 7
    purge_protection_enabled        = true
    enabled_for_deployment          = true
    enabled_for_disk_encryption     = true
    enabled_for_template_deployment = false
    rbac_authorization_enabled      = false
    public_network_access_enabled   = true
    tags = {
      environment = "production"
      owner       = "team-prod"
    }

    access_policies = [
      {
        key_permissions         = ["Get", "List", "Create", "Delete"]
        secret_permissions      = ["Get", "Set", "List", "Delete"]
        certificate_permissions = ["Get", "Import", "Delete"]
        storage_permissions     = ["Get"]
      }
    ]
  }
}

key_vault_secrets = {
  "sc1" = {
    kv_secret           = "vm1-username"
    kv_value            = "akkcadmin"
    rg_key              = "rg1"
    kv_name             = "dev-keyvault-777"
    resource_group_name = ""
  }
  "sc2" = {
    kv_secret           = "vm1-password"
    kv_value            = "Devops#4321!"
    rg_key              = "rg1"
    kv_name             = "dev-keyvault-777"
    resource_group_name = ""
  }
  "sc3" = {
    kv_secret           = "sql-username"
    kv_value            = "akkcsqladmin"
    rg_key              = "rg1"
    kv_name             = "dev-keyvault-777"
    resource_group_name = ""
  }
  "sc4" = {
    kv_secret           = "sql-password"
    kv_value            = "Devops#4321!"
    rg_key              = "rg1"
    kv_name             = "dev-keyvault-777"
    resource_group_name = ""
  }
}

lvm = {
  vm1 = {
    vm_name                         = "linux-vm-01"
    resource_group_name             = ""
    rg_key                          = "rg1"
    location                        = "West Europe"
    size                            = "Standard_B2s"
    nic_name                        = "akkc-nic01"
    kv_name                         = "dev-keyvault-777"
    username_secret                 = "vm1-username"
    password_secret                 = "vm1-password"
    size                            = "Standard_F2"
    disable_password_authentication = false
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

wvm = {
  vm1 = {
    rg_key          = "rg2"
    vm_name         = "demo-wvm"
    kv_rg           = "PROJECT-JARVIS-WESTUS-FINAL-RG"
    kv_name         = "dev-keyvault-777"
    location        = "CanadaCentral"
    nic_name        = "akkc-nic02"
    size            = "Standard_B1s"
    username_secret = "vm1-username"
    password_secret = "vm1-password"

    os_disk = {
      name                 = "demo-osdisk"
      caching              = "ReadWrite"
      storage_account_type = "Standard_LRS"
      disk_size_gb         = 128
    }

    source_image_reference = {
      publisher = "MicrosoftWindowsServer"
      offer     = "WindowsServer"
      sku       = "2022-datacenter"
      version   = "latest"
    }
  }
}
