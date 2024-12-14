# ID da AMI
variable "ami_id" {
  description = "ID da AMI para a EC2"
  type        = string
}

# Tipo de instância
variable "instance_type" {
  description = "Tipo da instância EC2"
  type        = string
  default     = "t2.micro"
}

# Nome da chave SSH
variable "key_name" {
  description = "Nome do par de chaves SSH"
  type        = string
}

# Caminho para a chave pública SSH
variable "public_key_path" {
  description = "Caminho para o arquivo da chave pública SSH"
  type        = string
}

# Subnet pública
variable "public_subnet_id" {
  description = "ID da subnet pública para a EC2"
  type        = string
}

# Security Group
variable "security_group_id" {
  description = "ID do Security Group associado à EC2"
  type        = string
}
