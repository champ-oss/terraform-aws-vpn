provider "aws" {
  region = "us-west-1"
}

locals {
  git = "terraform-aws-vpn"
}

data "aws_route53_zone" "this" {
  name = "oss.champtest.net."
}

module "vpc" {
  source                   = "github.com/champ-oss/terraform-aws-vpc.git?ref=v1.0.49-a63798e"
  name                     = local.git
  availability_zones_count = 2
  retention_in_days        = 1
}

module "acm" {
  source            = "github.com/champ-oss/terraform-aws-acm.git?ref=v1.0.112-8f39765"
  git               = local.git
  domain_name       = "${local.git}.${data.aws_route53_zone.this.name}"
  create_wildcard   = false
  zone_id           = data.aws_route53_zone.this.zone_id
  enable_validation = true
}

module "this" {
  source                     = "../../"
  git                        = local.git
  server_certificate_arn     = module.acm.arn
  authentication_type        = "certificate-authentication"
  root_certificate_chain_arn = module.acm.arn
  subnet_id                  = module.vpc.private_subnets_ids[0]
  vpc_id                     = module.vpc.vpc_id
}
