# VNet
resource "azurerm_virtual_network" "vnet_meuprojeto" {
  name                = "vnet_meuprojeto"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg_meuprojeto.location
  resource_group_name = azurerm_resource_group.rg_meuprojeto.name
}

# Criar uma subnet
resource "azurerm_subnet" "subnet_meuprojeto" {
  name                 = "subnet_meuprojeto"
  resource_group_name  = azurerm_resource_group.rg_meuprojeto.name
  virtual_network_name = azurerm_virtual_network.vnet_meuprojeto.name
  address_prefixes     = ["10.0.0.0/24"]
}

# IP público
resource "azurerm_public_ip" "publicip_server01" {
  name                = "ippublic_meuprojeto_server01"
  resource_group_name = azurerm_resource_group.rg_meuprojeto.name
  location            = azurerm_resource_group.rg_meuprojeto.location
  allocation_method   = "Static"
  sku                 = "Standard"
  domain_name_label   = join("-", ["server01", random_id.dns.dec])
}

resource "azurerm_public_ip" "publicip_server02" {
  name                = "ippublic_meuprojeto_server02"
  resource_group_name = azurerm_resource_group.rg_meuprojeto.name
  location            = azurerm_resource_group.rg_meuprojeto.location
  allocation_method   = "Static"
  sku                 = "Standard"
  domain_name_label   = join("-", ["server02", random_id.dns.dec])
}

# Criar uma placa de rede (NIC)
resource "azurerm_network_interface" "nic_server01" {
  name                = "nic_meuprojeto_server01"
  location            = azurerm_resource_group.rg_meuprojeto.location
  resource_group_name = azurerm_resource_group.rg_meuprojeto.name

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = azurerm_subnet.subnet_meuprojeto.id
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.0.0.4"
    public_ip_address_id          = azurerm_public_ip.publicip_server01.id
  }
}

resource "azurerm_network_interface" "nic_server02" {
  name                = "nic_meuprojeto_server02"
  location            = azurerm_resource_group.rg_meuprojeto.location
  resource_group_name = azurerm_resource_group.rg_meuprojeto.name

  ip_configuration {
    name                          = "ipconfig2"
    subnet_id                     = azurerm_subnet.subnet_meuprojeto.id
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.0.0.5"
    public_ip_address_id          = azurerm_public_ip.publicip_server02.id
  }
}

# Criar NSG (Network Security Group)
resource "azurerm_network_security_group" "nsg" {
  name                = "nsg_meuprojeto"
  location            = azurerm_resource_group.rg_meuprojeto.location
  resource_group_name = azurerm_resource_group.rg_meuprojeto.name

  # Permite SSH (2222)
  security_rule {
    name                       = "allow-ssh2222"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_ranges    = ["2222"]
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  # Permite HTTP e HTTPS somente para o server01
  security_rule {
    name                       = "allow-ssh-http-https"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_ranges    = ["80", "443"]
    source_address_prefix      = "*"
    destination_address_prefix = "10.0.0.4"
  }

  # Permite que o server01 se conecte ao serviço MariaDB do server02
  security_rule {
    name                       = "allow-mariadb-server01-to-server02"
    priority                   = 120
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "10.0.0.4"
    destination_address_prefix = "10.0.0.5"
  }
}

# Associar a NSG às subnets
resource "azurerm_subnet_network_security_group_association" "nsg_subnets" {
  subnet_id                 = azurerm_subnet.subnet_meuprojeto.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

# Associar as NICs à NSG
resource "azurerm_network_interface_security_group_association" "nsg_nic_server01" {
  network_interface_id      = azurerm_network_interface.nic_server01.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

resource "azurerm_network_interface_security_group_association" "nsg_nic_server02" {
  network_interface_id      = azurerm_network_interface.nic_server02.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

# Criar sufixo para o DNS
resource "random_id" "dns" {
  byte_length = 3
}


