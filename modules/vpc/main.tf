# Cria a VPC
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "main-vpc"
  }
}

# Subnets Públicas
resource "aws_subnet" "public" {
  count                   = var.public_subnet_count
  cidr_block              = element(var.public_subnets_cidrs, count.index)
  vpc_id                  = aws_vpc.main.id
  map_public_ip_on_launch = true
  availability_zone       = element(var.azs, count.index)
  tags = {
    Name = "public-subnet-${count.index}"
  }
}

# Subnets Privadas
resource "aws_subnet" "private" {
  count             = var.private_subnet_count
  cidr_block        = element(var.private_subnets_cidrs, count.index)
  vpc_id            = aws_vpc.main.id
  availability_zone = element(var.azs, count.index)
  tags = {
    Name = "private-subnet-${count.index}"
  }
}

# Elastic IP para o NAT Gateway
resource "aws_eip" "nat" {
  vpc = true
  tags = {
    Name = "nat-eip"
  }
}

# NAT Gateway
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public[0].id
  tags = {
    Name = "nat-gateway"
  }
}

# Security Group
resource "aws_security_group" "web_sg" {
  vpc_id = aws_vpc.main.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "web-security-group"
  }
}
