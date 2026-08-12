resource "aws_iam_saml_provider" "this" {
  count                  = var.saml_metadata_document != null ? 1 : 0
  name                   = coalesce(var.saml_provider_name, "${var.git}-vpn")
  saml_metadata_document = var.saml_metadata_document
  tags                   = merge(local.tags, var.tags)
}

resource "aws_iam_saml_provider" "self_service" {
  count                  = var.self_service_saml_metadata_document != null ? 1 : 0
  name                   = coalesce(var.self_service_saml_provider_name, "${var.git}-vpn-self-service")
  saml_metadata_document = var.self_service_saml_metadata_document
  tags                   = merge(local.tags, var.tags)
}
