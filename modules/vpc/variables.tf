# CIDR da VPC
variable "vpc_cidr" {
  description = "CIDR para a VPC"
  default     = "10.0.0.0/16"
}

# Subnets Públicas
variable "public_subnet_count" {
  description = "Quantidade de subnets públicas"
  default     = 2
}

variable "public_subnets_cidrs" {
  description = "CIDRs das subnets públicas"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

# Subnets Privadas
variable "private_subnet_count" {
  description = "Quantidade de subnets privadas"
  default     = 2
}

variable "private_subnets_cidrs" {
  description = "CIDRs das subnets privadas"
  type        = list(string)
  default     = ["10.0.3.0/24", "10.0.4.0/24"]
}

# Availability Zones
variable "azs" {
  description = "Zonas de disponibilidade para as subnets"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}