# Definir o região no MS Azure
variable "location_name" {
  type    = string
  default = "eastus2"
}

# Imagem do sistema operacional
variable "image_publisher" {
  type    = string
  default = "Debian"
}

variable "image_offer" {
  type    = string
  default = "debian-12"
}

variable "image_sku" {
  type    = string
  default = "12-gen2"
}

variable "image_version" {
  type    = string
  default = "latest"
}

# Configuração do banco de dados

variable "db_name" {
  description = "Nome do banco para o PI"
  type        = string
  default     = "meuprojeto"
}

variable "db_user" {
  description = "Usuário do banco do PI"
  type        = string
  default     = "appuser"
}

variable "db_password" {
  description = "Senha do usuário do banco do PI"
  type        = string
  default     = "Meu49854Proje7o"
  sensitive   = true
}

# HTTPS
variable "lets_encrypt_email" {
  description = "Email para o Lets Encrypt"
  type        = string
  default     = "seu_email@seumemail.com"
}