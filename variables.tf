variable "git" {
  description = "Name of the Git repo"
  type        = string
}

variable "server_certificate_arn" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_client_vpn_endpoint#server_certificate_arn"
  type        = string
}

variable "subnet_id" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_client_vpn_network_association#subnet_id"
  type        = string
}

variable "vpc_id" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group#vpc_id"
  type        = string
}

variable "authentication_type" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_client_vpn_endpoint#type"
  type        = string
  default     = "federated-authentication"
}

variable "active_directory_id" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_client_vpn_endpoint#active_directory_id"
  type        = string
  default     = null
}

variable "root_certificate_chain_arn" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_client_vpn_endpoint#root_certificate_chain_arn"
  type        = string
  default     = null
}

variable "saml_provider_arn" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_client_vpn_endpoint#saml_provider_arn"
  type        = string
  default     = null
}

variable "self_service_saml_provider_arn" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_client_vpn_endpoint#saml_provider_arn"
  type        = string
  default     = null
}

variable "saml_metadata_document" {
  description = "SAML metadata document (XML) for the IAM SAML provider used for authentication, e.g. downloaded from IAM Identity Center after rotating its signing certificate. When set, this module creates and manages the aws_iam_saml_provider resource instead of requiring var.saml_provider_arn to already exist. https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_saml_provider#saml_metadata_document"
  type        = string
  default     = null
}

variable "self_service_saml_metadata_document" {
  description = "SAML metadata document (XML) for the IAM SAML provider used for the self-service portal, e.g. downloaded from IAM Identity Center after rotating its signing certificate. When set, this module creates and manages the aws_iam_saml_provider resource instead of requiring var.self_service_saml_provider_arn to already exist. https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_saml_provider#saml_metadata_document"
  type        = string
  default     = null
}

variable "saml_provider_name" {
  description = "Name of the IAM SAML provider used for authentication, created when var.saml_metadata_document is set. Defaults to \"<var.git>-vpn\". The name is immutable in AWS (changing it forces a new provider with a new ARN), so if you are importing a pre-existing aws_iam_saml_provider under this module's management, set this to that provider's exact current name first to avoid an unwanted replacement."
  type        = string
  default     = null
}

variable "self_service_saml_provider_name" {
  description = "Name of the IAM SAML provider used for the self-service portal, created when var.self_service_saml_metadata_document is set. Defaults to \"<var.git>-vpn-self-service\". The name is immutable in AWS (changing it forces a new provider with a new ARN), so if you are importing a pre-existing aws_iam_saml_provider under this module's management, set this to that provider's exact current name first to avoid an unwanted replacement."
  type        = string
  default     = null
}

variable "transport_protocol" {
  description = "https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-clientvpnendpoint.html#cfn-ec2-clientvpnendpoint-transportprotocol"
  type        = string
  default     = "tcp"
}

variable "enable_tcp_fallback" {
  description = "Create a second, TCP-only Client VPN endpoint alongside the primary one, for clients on networks that block UDP. A Client VPN endpoint only supports one transport protocol, so this requires var.transport_protocol to be \"udp\". The fallback endpoint shares the server certificate, SAML providers, security group, subnet association and log group with the primary endpoint."
  type        = bool
  default     = false
}

variable "tcp_fallback_client_cidr_block" {
  description = "Client CIDR block for the TCP fallback endpoint created by var.enable_tcp_fallback. Must not overlap with var.client_cidr_block or the VPC CIDR. https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_client_vpn_endpoint#client_cidr_block"
  type        = string
  default     = "10.254.0.0/16"
}

variable "tags" {
  description = "Map of tags to assign to resources"
  type        = map(string)
  default     = {}
}

variable "dns_servers" {
  description = "https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-clientvpnendpoint.html#cfn-ec2-clientvpnendpoint-transportprotocol"
  type        = list(string)
  default = [
    "8.8.8.8",
    "8.8.4.4"
  ]
}

variable "client_cidr_block" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_client_vpn_endpoint#client_cidr_block"
  type        = string
  default     = "10.255.0.0/16"
}

variable "retention_in_days" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group#retention_in_days"
  type        = number
  default     = 731
}

variable "security_groups" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_client_vpn_network_association#security_groups"
  type        = list(string)
  default     = []
}

locals {
  tags = {
    git       = var.git
    cost      = "shared"
    creator   = "terraform"
    component = "vpn"
  }

  # Prefer the SAML provider created by this module (when a metadata document is supplied) and fall
  # back to a pre-existing provider ARN otherwise. This is what lets a rotated IAM Identity Center
  # signing certificate be applied by just updating var.saml_metadata_document.
  saml_provider_arn              = var.saml_metadata_document != null ? aws_iam_saml_provider.this[0].arn : var.saml_provider_arn
  self_service_saml_provider_arn = var.self_service_saml_metadata_document != null ? aws_iam_saml_provider.self_service[0].arn : var.self_service_saml_provider_arn
}