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

variable "transport_protocol" {
  description = "https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-clientvpnendpoint.html#cfn-ec2-clientvpnendpoint-transportprotocol"
  type        = string
  default     = "tcp"
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
}