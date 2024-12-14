# Criação do par de chaves para acesso à EC2
resource "aws_key_pair" "key" {
  key_name   = var.key_name
  public_key = file(var.public_key_path)
}

# Instância EC2
resource "aws_instance" "web" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = aws_key_pair.key.key_name
  subnet_id              = var.public_subnet_id
  vpc_security_group_ids = [var.security_group_id]

  user_data = <<-EOF
    #!/bin/bash
    # Atualiza pacotes e instala Docker
    apt-get update -y
    apt-get install -y docker.io

    # Inicia Docker e adiciona ao startup
    systemctl start docker
    systemctl enable docker

    # Executa aplicação web simples no Nginx
    docker run -d -p 80:80 nginx
  EOF

  tags = {
    Name = "web-instance"
  }
}