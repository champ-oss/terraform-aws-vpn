locals {
  git = "terraform-aws-vpn"
}

data "aws_route53_zone" "this" {
  name = "oss.champtest.net."
}

data "aws_vpcs" "this" {
  tags = {
    purpose = "vega"
  }
}

data "aws_subnets" "this" {
  tags = {
    purpose = "vega"
    Type    = "Private"
  }

  filter {
    name   = "vpc-id"
    values = [data.aws_vpcs.this.ids[0]]
  }
}

module "acm" {
  source            = "github.com/champ-oss/terraform-aws-acm.git?ref=v1.0.115-bfc08dd"
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
  subnet_id                  = data.aws_subnets.this.ids[0]
  vpc_id                     = data.aws_vpcs.this.ids[0]
}
