# Nome do domínio de origem
variable "origin_domain_name" {
  description = "Nome do domínio ou endereço IP de origem para o CloudFront (Ex.: DNS público da EC2)"
  type        = string
}

# Nome da distribuição
variable "cloudfront_distribution_name" {
  description = "Nome da distribuição do CloudFront"
  type        = string
  default     = "web-cloudfront-distribution"
}
