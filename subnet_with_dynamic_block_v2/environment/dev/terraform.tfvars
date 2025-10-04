resource_group_name  = "dynamic-block-rg"

location             = "West Europe"

virtual_network_name = "dynamic-block-vnet"

address_space        = ["10.0.0.0/16"]

subnets = {
  subnet1 = {
    subnet           = "dynamic-subnet1"
    address_prefixes = ["10.0.1.0/24"]
  }
  subnet2 = {
    subnet           = "dynamic-subnet2"
    address_prefixes = ["10.0.2.0/24"]
  }
}

subscription_id = "b398fea1-2f06-4948-924a-121d4ed265b0"


security_rules = {
  rule1 = {
    name                       = "Allow-HTTP"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "80"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  rule2 = {
    name                       = "Allow-HTTPS"
    priority                   = 200
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "443"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  rule3 = {
    name                       = "Allow-SSH"
    priority                   = 201
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "22"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

nsg_name = "dynamic-nsg"

nics = {
  nic1 = {
    location                      = "West Europe"
    resource_group_name           = "dynamic-block-rg"
    ip_configuration_name         = "ipconfig1"
    private_ip_address_allocation = "Dynamic"
    private_ip_address_version    = "IPv4"
  }

  nic2 = {
    location                      = "West Europe"
    resource_group_name           = "dynamic-block-rg"
    ip_configuration_name         = "ipconfig2"
    private_ip_address_allocation = "Dynamic"
    private_ip_address_version    = "IPv4"
  }
}
