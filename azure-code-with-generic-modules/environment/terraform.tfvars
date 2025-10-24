subscription_id = "b398fea1-2f06-4948-924a-121d4ed265b0"

resource_groups = {
  rg1 = {
    name       = "rg1"
    location   = "West Europe"
    managed_by = "tony_stark"
    tags = {
      environment = "dev"
      project     = "jarvis"
      owner       = "team_stark"
    }
  }
  rg2 = {
    name       = "rg2"
    location   = "East US"
    managed_by = "steve_rogers"
    tags = {
      environment = "prod"
      project     = "vision"
      owner       = "team_rogers"
    }
  }
}

stgaccount = {
  stgacc1 = {
    name                     = "stgaccwestus001"
    resource_group_name      = "rg1"
    location                 = "eastus"
    account_tier             = "Standard"
    account_replication_type = "LRS"
    tags = {
      environment = "dev"
      project     = "jarvis"
      owner       = "team_stark"
    }
    access_tier                       = "Hot"
  #   provisioned_billing_model_version = "V2"
  #   cross_tenant_replication_enabled  = false
  #   # edge_zone                         = "eastus"
  #   https_traffic_only_enabled        = true
  #   min_tls_version                   = "TLS1_2"
  #   shared_access_key_enabled         = true
  #   allow_nested_items_to_be_public   = false
  #   public_network_access_enabled     = true
  #   default_to_oauth_authentication   = false
  #   is_hns_enabled                    = true
  #   nfsv3_enabled                     = false
  #   large_file_share_enabled          = false
  #   local_user_enabled                = false
  #   queue_encryption_key_type         = "Account"
  #   table_encryption_key_type         = "Account"
  #   infrastructure_encryption_enabled = false
  #   dns_endpoint_type                 = "Standard"
  #   sftp_enabled                      = false
  #   allowed_copy_scope                = "PrivateLink"
  }

  # stg2 = {
  #   name                     = "stgacceastus002"
  #   resource_group_name      = "rg2"
  #   location                 = "East US"
  #   account_tier             = "Standard"
  #   account_replication_type = "GRS"
  #   tags = {
  #     environment = "prod"
  #     project     = "vision"
  #     owner       = "team_rogers"
  #   }
  # }
}

vnets = {
  vnet1 = {
    name                = "vnet1"
    resource_group_name = "rg1"
    location            = "West Europe"
    address_space       = ["192.168.0.0/21"]
    subnet = {
      subnet1 = {
        name             = "subnet1"
        address_prefixes = ["192.168.1.0/24"]
      }
    }
  }
  vnet2 = {
    name                = "vnet1-rg2"
    resource_group_name = "rg2"
    location            = "West Europe"
    address_space       = ["192.168.0.0/21"]
  }
}

pips = {
  pip1 = {
    name                = "pip1"
    location            = "West Europe"
    resource_group_name = "rg1"
    allocation_method   = "Static"
    sku                 = "Standard"
    tags = {
      environment = "dev"
      project     = "jarvis"
      owner       = "team_stark"
    }
  }
  # pip2 = {
  #   name                = "pip2"
  #   location            = "East US"
  #   resource_group_name = "rg2"
  #   allocation_method   = "Dynamic"
  #   sku                 = "Basic"
  #   tags = {
  #     environment = "prod"
  #     project     = "vision"
  #     owner       = "team_rogers"
  #   }
  # }
}

nics = {
  nic1 = {
    name                = "nic1"
    location            = "West Europe"
    resource_group_name = "rg1"
    ip_configuration = [
      {
        name                          = "ipconfig1"
        private_ip_address_allocation = "Dynamic"
        subnet_key                    = "subnet1"
        vnet_key                    = "vnet1"
        pip_key                       = "pip1"
      }
    ]

    tags = {
      environment = "dev"
      project     = "jarvis"
      owner       = "team_stark"
    }
  }
  # nic2 = {
  #   name                = "nic2"
  #   location            = "East US"
  #   resource_group_name = "rg2"
  #   ip_configuration = [
  #     {
  #       name                          = "ipconfig1"
  #       private_ip_address_allocation = "Dynamic"
  #       subnet_key                    = "subnet2"
  #       pip_key                       = "pip2"
  #     }
  #   ]

  #   tags = {
  #     environment = "prod"
  #     project     = "vision"
  #     owner       = "team_rogers"
  #   }
  # }
}

nsg = {
  "nsg1" = {
    nsg_name                = "nsg1"
    location            = "West Europe"
    resource_group_name = "rg1"
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