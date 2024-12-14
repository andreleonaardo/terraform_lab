module "vpc" {
  source                 = "./modules/vpc"
  vpc_cidr               = "10.0.0.0/16"
  public_subnet_count    = 2
  private_subnet_count   = 2
  public_subnets_cidrs   = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnets_cidrs  = ["10.0.3.0/24", "10.0.4.0/24"]
  azs                    = ["us-east-1a", "us-east-1b"]
}

module "ec2" {
  source             = "./modules/ec2"
  ami_id             = "ami-0c02fb55956c7d316" # Ubuntu 20.04 LTS (Freetier)
  instance_type      = "t2.micro"
  key_name           = "my-terraform-key"
  public_key_path    = "~/.ssh/id_rsa.pub"
  public_subnet_id   = element(module.vpc.public_subnets, 0)
  security_group_id  = module.vpc.web_security_group_id
}

module "cloudfront" {
  source                     = "./modules/cloudfront"
  origin_domain_name         = module.ec2.public_dns
  cloudfront_distribution_name = "web-cloudfront"
}
