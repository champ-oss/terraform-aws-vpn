# An AWS Client VPN endpoint supports exactly one transport protocol, so a TCP fallback for clients
# on networks that block UDP has to be a second endpoint. It shares the server certificate, SAML
# providers, security group and log group with the primary endpoint, so clients get the same access
# and auth regardless of which of the two profiles they connect with.
resource "aws_ec2_client_vpn_endpoint" "tcp_fallback" {
  count                  = var.enable_tcp_fallback ? 1 : 0
  description            = "${var.git} (TCP fallback)"
  server_certificate_arn = var.server_certificate_arn
  client_cidr_block      = var.tcp_fallback_client_cidr_block
  tags                   = merge({ Name = "${var.git}-tcp-fallback" }, local.tags, var.tags)
  transport_protocol     = "tcp"
  dns_servers            = var.dns_servers
  self_service_portal    = "enabled"
  security_group_ids     = concat(var.security_groups, [aws_security_group.vpn.id])
  vpc_id                 = var.vpc_id

  authentication_options {
    type                           = var.authentication_type
    active_directory_id            = var.active_directory_id
    root_certificate_chain_arn     = var.root_certificate_chain_arn
    saml_provider_arn              = local.saml_provider_arn
    self_service_saml_provider_arn = local.self_service_saml_provider_arn
  }

  connection_log_options {
    enabled               = true
    cloudwatch_log_group  = aws_cloudwatch_log_group.this.name
    cloudwatch_log_stream = aws_cloudwatch_log_stream.tcp_fallback[0].name
  }

  lifecycle {
    precondition {
      condition     = var.transport_protocol == "udp"
      error_message = "var.enable_tcp_fallback creates a second, TCP-only endpoint to fall back to, so the primary endpoint must be UDP. Set var.transport_protocol to \"udp\"."
    }

    precondition {
      condition     = var.tcp_fallback_client_cidr_block != var.client_cidr_block
      error_message = "var.tcp_fallback_client_cidr_block must not be the same as var.client_cidr_block, otherwise the two endpoints hand out overlapping client addresses."
    }
  }
}

resource "aws_cloudwatch_log_stream" "tcp_fallback" {
  count          = var.enable_tcp_fallback ? 1 : 0
  name           = "vpn-tcp-fallback"
  log_group_name = aws_cloudwatch_log_group.this.name
}

resource "aws_ec2_client_vpn_authorization_rule" "tcp_fallback" {
  count                  = var.enable_tcp_fallback ? 1 : 0
  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.tcp_fallback[0].id
  target_network_cidr    = "0.0.0.0/0"
  authorize_all_groups   = true
}

resource "aws_ec2_client_vpn_route" "tcp_fallback" {
  count                  = var.enable_tcp_fallback ? 1 : 0
  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.tcp_fallback[0].id
  destination_cidr_block = "0.0.0.0/0"
  target_vpc_subnet_id   = aws_ec2_client_vpn_network_association.tcp_fallback[0].subnet_id
}

resource "aws_ec2_client_vpn_network_association" "tcp_fallback" {
  count                  = var.enable_tcp_fallback ? 1 : 0
  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.tcp_fallback[0].id
  subnet_id              = var.subnet_id
}
