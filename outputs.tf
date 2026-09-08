output "client_vpn_endpoint_id" {
  description = "ID of the Client VPN endpoint"
  value       = aws_ec2_client_vpn_endpoint.this.id
}

output "client_vpn_endpoint_dns_name" {
  description = "DNS name of the Client VPN endpoint"
  value       = aws_ec2_client_vpn_endpoint.this.dns_name
}

output "saml_provider_arn" {
  description = "ARN of the IAM SAML provider used for auth, either created by this module from var.saml_metadata_document or passed in via var.saml_provider_arn"
  value       = local.saml_provider_arn
}

output "self_service_saml_provider_arn" {
  description = "ARN of the IAM SAML provider used for the self-service portal, either created by this module from var.self_service_saml_metadata_document or passed in via var.self_service_saml_provider_arn"
  value       = local.self_service_saml_provider_arn
}

output "tcp_fallback_client_vpn_endpoint_id" {
  description = "ID of the TCP fallback Client VPN endpoint, or null when var.enable_tcp_fallback is false"
  value       = one(aws_ec2_client_vpn_endpoint.tcp_fallback[*].id)
}

output "tcp_fallback_client_vpn_endpoint_dns_name" {
  description = "DNS name of the TCP fallback Client VPN endpoint, or null when var.enable_tcp_fallback is false"
  value       = one(aws_ec2_client_vpn_endpoint.tcp_fallback[*].dns_name)
}
