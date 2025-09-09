output "server01_public_ip" {
  description = "IP público do server01 (Web)"
  value       = azurerm_public_ip.publicip_server01.ip_address
}

output "server02_public_ip" {
  description = "IP público do server02 (DB) - exposto apenas para SSH:2222"
  value       = azurerm_public_ip.publicip_server02.ip_address
}

output "web_url" {
  description = "URL de acesso ao site (HTTP)"
  value       = "https://${azurerm_public_ip.publicip_server01.fqdn}"
}

output "server01_fqdn" {
  value = azurerm_public_ip.publicip_server01.fqdn
}

output "server02_fqdn" {
  value = azurerm_public_ip.publicip_server02.fqdn
}

output "ssh_server01" {
  value = "ssh -i ~/.ssh/id_rsa -p 2222 azureuser@${azurerm_public_ip.publicip_server01.ip_address}"
}

output "ssh_server02" {
  value = "ssh -i ~/.ssh/id_rsa -p 2222 azureuser@${azurerm_public_ip.publicip_server02.ip_address}"
}