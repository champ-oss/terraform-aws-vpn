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
  source                   = "github.com/champ-oss/terraform-aws-vpc.git?ref=v1.0.1-afc8890"
  git                      = local.git
  availability_zones_count = 2
  retention_in_days        = 1
}

module "acm" {
  source            = "github.com/champ-oss/terraform-aws-acm.git?ref=v1.0.19-aae8917"
  git               = local.git
  domain_name       = "${local.git}.${data.aws_route53_zone.this.name}"
  create_wildcard   = false
  zone_id           = data.aws_route53_zone.this.zone_id
  enable_validation = true
}

resource "aws_iam_saml_provider" "provider" {
  name                   = local.git
  saml_metadata_document = file("saml-example.xml")
}

resource "aws_iam_saml_provider" "self_service" {
  name                   = "${local.git}-self-service"
  saml_metadata_document = file("saml-example.xml")
}

module "this" {
  source                         = "../../"
  git                            = local.git
  server_certificate_arn         = module.acm.arn
  saml_provider_arn              = aws_iam_saml_provider.provider.arn
  self_service_saml_provider_arn = aws_iam_saml_provider.self_service.arn
  subnet_id                      = module.vpc.private_subnets_ids[0]
  vpc_id                         = module.vpc.vpc_id
}