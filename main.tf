# Resource Group
resource "azurerm_resource_group" "rg_meuprojeto" {
  name     = "rg_meuprojeto"
  location = var.location_name
}

# VM Server01 (Nginx, PHP e PHPMyAdmin)
resource "azurerm_linux_virtual_machine" "server01" {
  name                            = "server01"
  computer_name                   = "server01"
  resource_group_name             = azurerm_resource_group.rg_meuprojeto.name
  location                        = azurerm_resource_group.rg_meuprojeto.location
  size                            = "Standard_B1ms"
  admin_username                  = "azureuser"
  disable_password_authentication = false
  network_interface_ids           = [azurerm_network_interface.nic_server01.id]
  admin_password                  = "TotoLindao@123"

  # Habilita cloud-init no Debian
  provision_vm_agent = true

  # Cloud-init
  custom_data = data.template_cloudinit_config.cloud_config_server01.rendered

  admin_ssh_key {
    username   = "azureuser"
    public_key = file(pathexpand("~/.ssh/id_rsa.pub"))
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = var.image_publisher
    offer     = var.image_offer
    sku       = var.image_sku
    version   = var.image_version
  }
}

# VM Server02 (MariaDB)
resource "azurerm_linux_virtual_machine" "server02" {
  name                            = "server02"
  computer_name                   = "server02"
  resource_group_name             = azurerm_resource_group.rg_meuprojeto.name
  location                        = azurerm_resource_group.rg_meuprojeto.location
  size                            = "Standard_B1ms"
  admin_username                  = "azureuser"
  disable_password_authentication = false
  network_interface_ids           = [azurerm_network_interface.nic_server02.id]
  admin_password                  = "TotoLindao@123"

  # Habilita cloud-init no Debian
  provision_vm_agent = true

  # Cloud-init
  custom_data = data.template_cloudinit_config.cloud_config_server02.rendered

  admin_ssh_key {
    username   = "azureuser"
    public_key = file(pathexpand("~/.ssh/id_rsa.pub"))
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = var.image_publisher
    offer     = var.image_offer
    sku       = var.image_sku
    version   = var.image_version
  }
}

# cloud-init
data "template_cloudinit_config" "cloud_config_server01" {
  gzip          = true
  base64_encode = true

  part {
    content_type = "text/cloud-config"
    content = templatefile("${path.module}/cloud-init-server01.yaml", {
      server02_private_ip = "10.0.0.5"
      db_name             = var.db_name
      db_user             = var.db_user
      db_password         = var.db_password
      server01_domain     = azurerm_public_ip.publicip_server01.fqdn
      letsencrypt_email   = var.lets_encrypt_email
    })
  }
}

data "template_cloudinit_config" "cloud_config_server02" {
  gzip          = true
  base64_encode = true

  part {
    content_type = "text/cloud-config"
    content = templatefile("${path.module}/cloud-init-server02.yaml", {
      server01_private_ip = "10.0.0.4"
      db_name             = var.db_name
      db_user             = var.db_user
      db_password         = var.db_password
    })
  }
}
