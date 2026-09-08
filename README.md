# terraform-aws-vpn

A Terraform module for deploying an AWS Client VPN Endpoint

[![.github/workflows/module.yml](https://github.com/champ-oss/terraform-aws-vpn/actions/workflows/module.yml/badge.svg?branch=main)](https://github.com/champ-oss/terraform-aws-vpn/actions/workflows/module.yml)
[![.github/workflows/lint.yml](https://github.com/champ-oss/terraform-aws-vpn/actions/workflows/lint.yml/badge.svg?branch=main)](https://github.com/champ-oss/terraform-aws-vpn/actions/workflows/lint.yml)
[![.github/workflows/sonar.yml](https://github.com/champ-oss/terraform-aws-vpn/actions/workflows/sonar.yml/badge.svg)](https://github.com/champ-oss/terraform-aws-vpn/actions/workflows/sonar.yml)

[![SonarCloud](https://sonarcloud.io/images/project_badges/sonarcloud-black.svg)](https://sonarcloud.io/summary/new_code?id=terraform-aws-vpn_champ-oss)

[![Quality Gate Status](https://sonarcloud.io/api/project_badges/measure?project=terraform-aws-vpn_champ-oss&metric=alert_status)](https://sonarcloud.io/summary/new_code?id=terraform-aws-vpn_champ-oss)
[![Vulnerabilities](https://sonarcloud.io/api/project_badges/measure?project=terraform-aws-vpn_champ-oss&metric=vulnerabilities)](https://sonarcloud.io/summary/new_code?id=terraform-aws-vpn_champ-oss)
[![Reliability Rating](https://sonarcloud.io/api/project_badges/measure?project=terraform-aws-vpn_champ-oss&metric=reliability_rating)](https://sonarcloud.io/summary/new_code?id=terraform-aws-vpn_champ-oss)

## Example Usage

See the `examples/` folder

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_log_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_cloudwatch_log_stream.tcp_fallback](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_stream) | resource |
| [aws_cloudwatch_log_stream.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_stream) | resource |
| [aws_ec2_client_vpn_authorization_rule.tcp_fallback](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_client_vpn_authorization_rule) | resource |
| [aws_ec2_client_vpn_authorization_rule.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_client_vpn_authorization_rule) | resource |
| [aws_ec2_client_vpn_endpoint.tcp_fallback](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_client_vpn_endpoint) | resource |
| [aws_ec2_client_vpn_endpoint.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_client_vpn_endpoint) | resource |
| [aws_ec2_client_vpn_network_association.tcp_fallback](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_client_vpn_network_association) | resource |
| [aws_ec2_client_vpn_network_association.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_client_vpn_network_association) | resource |
| [aws_ec2_client_vpn_route.tcp_fallback](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_client_vpn_route) | resource |
| [aws_ec2_client_vpn_route.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_client_vpn_route) | resource |
| [aws_iam_saml_provider.self_service](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_saml_provider) | resource |
| [aws_iam_saml_provider.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_saml_provider) | resource |
| [aws_security_group.vpn](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_active_directory_id"></a> [active\_directory\_id](#input\_active\_directory\_id) | https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_client_vpn_endpoint#active_directory_id | `string` | `null` | no |
| <a name="input_authentication_type"></a> [authentication\_type](#input\_authentication\_type) | https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_client_vpn_endpoint#type | `string` | `"federated-authentication"` | no |
| <a name="input_client_cidr_block"></a> [client\_cidr\_block](#input\_client\_cidr\_block) | https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_client_vpn_endpoint#client_cidr_block | `string` | `"10.255.0.0/16"` | no |
| <a name="input_dns_servers"></a> [dns\_servers](#input\_dns\_servers) | https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-clientvpnendpoint.html#cfn-ec2-clientvpnendpoint-transportprotocol | `list(string)` | <pre>[<br>  "8.8.8.8",<br>  "8.8.4.4"<br>]</pre> | no |
| <a name="input_enable_tcp_fallback"></a> [enable\_tcp\_fallback](#input\_enable\_tcp\_fallback) | Create a second, TCP-only Client VPN endpoint alongside the primary one, for clients on networks that block UDP. A Client VPN endpoint only supports one transport protocol, so this requires var.transport\_protocol to be "udp". The fallback endpoint shares the server certificate, SAML providers, security group, subnet association and log group with the primary endpoint. | `bool` | `false` | no |
| <a name="input_git"></a> [git](#input\_git) | Name of the Git repo | `string` | n/a | yes |
| <a name="input_retention_in_days"></a> [retention\_in\_days](#input\_retention\_in\_days) | https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group#retention_in_days | `number` | `731` | no |
| <a name="input_root_certificate_chain_arn"></a> [root\_certificate\_chain\_arn](#input\_root\_certificate\_chain\_arn) | https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_client_vpn_endpoint#root_certificate_chain_arn | `string` | `null` | no |
| <a name="input_saml_metadata_document"></a> [saml\_metadata\_document](#input\_saml\_metadata\_document) | SAML metadata document (XML) for the IAM SAML provider used for authentication, e.g. downloaded from IAM Identity Center after rotating its signing certificate. When set, this module creates and manages the aws\_iam\_saml\_provider resource instead of requiring var.saml\_provider\_arn to already exist. https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_saml_provider#saml_metadata_document | `string` | `null` | no |
| <a name="input_saml_provider_arn"></a> [saml\_provider\_arn](#input\_saml\_provider\_arn) | https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_client_vpn_endpoint#saml_provider_arn | `string` | `null` | no |
| <a name="input_saml_provider_name"></a> [saml\_provider\_name](#input\_saml\_provider\_name) | Name of the IAM SAML provider used for authentication, created when var.saml\_metadata\_document is set. Defaults to "<var.git>-vpn". The name is immutable in AWS (changing it forces a new provider with a new ARN), so if you are importing a pre-existing aws\_iam\_saml\_provider under this module's management, set this to that provider's exact current name first to avoid an unwanted replacement. | `string` | `null` | no |
| <a name="input_security_groups"></a> [security\_groups](#input\_security\_groups) | https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_client_vpn_network_association#security_groups | `list(string)` | `[]` | no |
| <a name="input_self_service_saml_metadata_document"></a> [self\_service\_saml\_metadata\_document](#input\_self\_service\_saml\_metadata\_document) | SAML metadata document (XML) for the IAM SAML provider used for the self-service portal, e.g. downloaded from IAM Identity Center after rotating its signing certificate. When set, this module creates and manages the aws\_iam\_saml\_provider resource instead of requiring var.self\_service\_saml\_provider\_arn to already exist. https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_saml_provider#saml_metadata_document | `string` | `null` | no |
| <a name="input_self_service_saml_provider_arn"></a> [self\_service\_saml\_provider\_arn](#input\_self\_service\_saml\_provider\_arn) | https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_client_vpn_endpoint#saml_provider_arn | `string` | `null` | no |
| <a name="input_self_service_saml_provider_name"></a> [self\_service\_saml\_provider\_name](#input\_self\_service\_saml\_provider\_name) | Name of the IAM SAML provider used for the self-service portal, created when var.self\_service\_saml\_metadata\_document is set. Defaults to "<var.git>-vpn-self-service". The name is immutable in AWS (changing it forces a new provider with a new ARN), so if you are importing a pre-existing aws\_iam\_saml\_provider under this module's management, set this to that provider's exact current name first to avoid an unwanted replacement. | `string` | `null` | no |
| <a name="input_server_certificate_arn"></a> [server\_certificate\_arn](#input\_server\_certificate\_arn) | https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_client_vpn_endpoint#server_certificate_arn | `string` | n/a | yes |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_client_vpn_network_association#subnet_id | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Map of tags to assign to resources | `map(string)` | `{}` | no |
| <a name="input_tcp_fallback_client_cidr_block"></a> [tcp\_fallback\_client\_cidr\_block](#input\_tcp\_fallback\_client\_cidr\_block) | Client CIDR block for the TCP fallback endpoint created by var.enable\_tcp\_fallback. Must not overlap with var.client\_cidr\_block or the VPC CIDR. https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_client_vpn_endpoint#client_cidr_block | `string` | `"10.254.0.0/16"` | no |
| <a name="input_transport_protocol"></a> [transport\_protocol](#input\_transport\_protocol) | https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-clientvpnendpoint.html#cfn-ec2-clientvpnendpoint-transportprotocol | `string` | `"tcp"` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group#vpc_id | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_client_vpn_endpoint_dns_name"></a> [client\_vpn\_endpoint\_dns\_name](#output\_client\_vpn\_endpoint\_dns\_name) | DNS name of the Client VPN endpoint |
| <a name="output_client_vpn_endpoint_id"></a> [client\_vpn\_endpoint\_id](#output\_client\_vpn\_endpoint\_id) | ID of the Client VPN endpoint |
| <a name="output_saml_provider_arn"></a> [saml\_provider\_arn](#output\_saml\_provider\_arn) | ARN of the IAM SAML provider used for authentication, either created by this module from var.saml\_metadata\_document or passed in via var.saml\_provider\_arn |
| <a name="output_self_service_saml_provider_arn"></a> [self\_service\_saml\_provider\_arn](#output\_self\_service\_saml\_provider\_arn) | ARN of the IAM SAML provider used for the self-service portal, either created by this module from var.self\_service\_saml\_metadata\_document or passed in via var.self\_service\_saml\_provider\_arn |
| <a name="output_tcp_fallback_client_vpn_endpoint_dns_name"></a> [tcp\_fallback\_client\_vpn\_endpoint\_dns\_name](#output\_tcp\_fallback\_client\_vpn\_endpoint\_dns\_name) | DNS name of the TCP fallback Client VPN endpoint, or null when var.enable\_tcp\_fallback is false |
| <a name="output_tcp_fallback_client_vpn_endpoint_id"></a> [tcp\_fallback\_client\_vpn\_endpoint\_id](#output\_tcp\_fallback\_client\_vpn\_endpoint\_id) | ID of the TCP fallback Client VPN endpoint, or null when var.enable\_tcp\_fallback is false |
<!-- END_TF_DOCS -->

## Features

### TCP fallback

UDP is the better default for a Client VPN endpoint (lower latency, no TCP-over-TCP meltdown), but
some corporate and public Wi-Fi networks block UDP/1194 outright. A Client VPN endpoint supports
exactly one transport protocol, so covering both means running two endpoints:

```hcl
transport_protocol  = "udp"
enable_tcp_fallback = true
```

That creates a second TCP endpoint sharing the primary's server certificate, SAML providers,
security group, subnet association and CloudWatch log group (under its own `vpn-tcp-fallback` log
stream), so clients get the same access and authentication either way. The two endpoints need
non-overlapping client address pools — see `var.tcp_fallback_client_cidr_block`.

Distribute both `.ovpn` profiles to users (the fallback endpoint's own self-service portal is
enabled too) and have them connect with the TCP one only when UDP fails. Because these are separate
endpoints, each associated subnet is billed per endpoint, and a connected user is billed on
whichever endpoint they are actually using.

### Rotating an IAM Identity Center SAML signing certificate

If `authentication_type = "federated-authentication"` and IAM Identity Center is the SAML source,
IAM Identity Center's signing certificate periodically needs to be rotated before it expires.
`aws_iam_saml_provider.this` and `.self_service` are two independent resources — a given rotation
only touches whichever one(s) actually had their certificate rotated; there's no need to update
both together unless both did.

SAML IdP metadata isn't secret (it's just the entity ID, SSO endpoint, and public signing
certificate), so it's fine to save the downloaded XML as a file next to your root config and
commit it — this also makes each rotation a plain file diff instead of an HCL edit:

```hcl
saml_metadata_document              = file("vpn-saml-metadata.xml")
self_service_saml_metadata_document = file("vpn-saml-metadata-self-service.xml")
```

If the provider(s) are already managed by this module (created via `saml_metadata_document` /
`self_service_saml_metadata_document`, not just referenced by ARN), rotate as follows:

1. In the IAM Identity Center console, rotate/refresh the signing certificate for whichever custom
   SAML application(s) backing this Client VPN endpoint need it (the regular application and/or,
   if used, the self-service one), then download the updated IdP SAML metadata XML for each.
2. Overwrite the corresponding local file (e.g. `vpn-saml-metadata.xml` and/or
   `vpn-saml-metadata-self-service.xml`) with the newly downloaded XML — same filename, so no HCL
   changes are needed if you're using `file()` as shown above.
3. Run `terraform plan` and confirm the diff shows **only** an in-place update to
   `saml_metadata_document` (and/or `self_service_saml_metadata_document`) on the affected
   `aws_iam_saml_provider` resource — no change to `name`, no replacement (`-/+`), no change to the
   ARN, and no forced change on `aws_ec2_client_vpn_endpoint`. If you see a replacement instead of
   an update, stop — that means the resource isn't the one already in state, or
   `var.saml_provider_name` / `var.self_service_saml_provider_name` doesn't match the real name.
4. Run `terraform apply`.
5. Verify: `aws iam get-saml-provider --saml-provider-arn <arn>` shows the new certificate and
   expiration date, then do a real VPN client connection through the rotated app to confirm SAML
   auth still succeeds end-to-end.
6. Commit the updated XML file(s) to git.

No `import` block is needed for a routine rotation — that's only for the one-time onboarding of a
provider that isn't in Terraform state yet (see below).

If you instead manage the `aws_iam_saml_provider` resource(s) outside of this module, keep passing
their ARNs via `var.saml_provider_arn` / `var.self_service_saml_provider_arn` and update that
resource's `saml_metadata_document` with the new XML wherever it's defined — this module only
consumes the ARN in that mode.

### Importing a pre-existing IAM SAML provider under this module

`aws_iam_saml_provider.name` is immutable in AWS — it cannot be changed in place, only replaced
(which issues a **new ARN** and breaks anything that trusts the old one, e.g. IAM role trust
policies or an in-use Client VPN endpoint). By default this module names the providers it creates
`"${var.git}-vpn"` and `"${var.git}-vpn-self-service"`.

If you want to bring an existing, externally-created `aws_iam_saml_provider` under this module's
management instead of letting the module create a new one, use an
[`import` block](https://developer.hashicorp.com/terraform/language/import) rather than the
`terraform import` CLI command, so you can preview the plan before anything changes. The examples
below assume the module is called `this` in your root config (`module "this" { source = ... }`,
matching `examples/complete`) — adjust the `to` address to match your own module call name.

1. Find the ARN of the existing provider(s), e.g. via the AWS console (IAM → Identity providers)
   or `aws iam list-saml-providers`. It looks like
   `arn:aws:iam::<account_id>:saml-provider/<name>` — the `<name>` segment after `saml-provider/`
   is the provider's immutable name.
2. Set `var.saml_provider_name` / `var.self_service_saml_provider_name` to that exact `<name>`.
   This is required — without it, the module's default computed name won't match the imported
   resource and the next `apply` will destroy and recreate the provider under a new ARN.
3. Set `var.saml_metadata_document` / `var.self_service_saml_metadata_document` to a metadata
   document XML — see the two options below depending on whether you're rotating the certificate
   as part of this same import.
4. Add an `import` block per provider you're importing, in any `.tf` file in your root module:

   ```hcl
   import {
     to = module.this.aws_iam_saml_provider.this
     id = "arn:aws:iam::123456789012:saml-provider/<existing-name>"
   }

   import {
     to = module.this.aws_iam_saml_provider.self_service
     id = "arn:aws:iam::123456789012:saml-provider/<existing-self-service-name>"
   }
   ```

   Only include the block(s) for the provider(s) you're actually importing.
5. Run `terraform plan` and check the plan for the imported resource(s) before applying:
   - **Importing as-is (no cert rotation):** use the provider's *current* metadata document XML
     for step 3. The plan should show the resource being imported with no changes. If it shows a
     replacement, `var.saml_provider_name` doesn't exactly match the real name — fix that first.
   - **Importing and rotating the certificate in the same apply:** use the *new*, rotated metadata
     document XML for step 3 instead (see the certificate rotation steps above for how to get it).
     The plan should show the resource being imported with an in-place update to
     `saml_metadata_document` only — never a replacement, since `name` is unchanged and only
     `name` forces recreation.
6. Run `terraform apply` to complete the import. Afterward, delete the `import` block(s) — they've
   done their job and Terraform will otherwise re-evaluate them (harmlessly, as a no-op) on every
   future plan.

## Contributing


