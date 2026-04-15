# Site-to-Site VPN

A demo simulating a site-to-site VPN between on-prem and AWS, using a StrongSwan instance as Customer Gateway

#### Storm Library for Terraform

This repository is a member of the SLT | Storm Library for Terraform,
a collection of Terraform modules for Amazon Web Services. The focus
of these modules, maintained in separate GitHub™ repositories, is on
building examples, demos and showcases on AWS. The audience of the
library is learners and presenters alike - people that want to know
or show how a certain service, pattern or solution looks like, or "feels".

[Learn more](https://github.com/stormreply/storm-library-for-terraform)

## Installation

This demo can be built using GitHub Actions. In order to do so

- [Install the Storm Library for Terraform](https://github.com/stormreply/storm-library-for-terraform/blob/main/docs/INSTALL-LIBRARY.md)
- [Deploy this member repository](https://github.com/stormreply/storm-library-for-terraform/blob/main/docs/DEPLOY-MEMBER.md)

Deployment of this member should take < 2 minutes on GitHub resources.

## Architecture

[Image]

## Explore this demo

1.



aws ec2 modify-vpn-tunnel-options \
  --vpn-connection-id vpn-xxxxxxxx \
  --tunnel-outside-ip-address 1.2.3.4 \
  --tunnel-options '{"TunnelLifecycleControl":"down"}'

## Terraform Docs

<details>
<summary>Click to show</summary>

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 6 |
| <a name="requirement_cloudinit"></a> [cloudinit](#requirement\_cloudinit) | >= 2 |
| <a name="requirement_local"></a> [local](#requirement\_local) | >= 2 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 6 |
| <a name="provider_cloudinit"></a> [cloudinit](#provider\_cloudinit) | >= 2 |
| <a name="provider_local"></a> [local](#provider\_local) | >= 2 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_cgw"></a> [cgw](#module\_cgw) | git::https://github.com/stormreply/ssm-managed-instance.git | n/a |
| <a name="module_instance-aws"></a> [instance-aws](#module\_instance-aws) | git::https://github.com/stormreply/ssm-managed-instance.git | n/a |
| <a name="module_instance-onprem"></a> [instance-onprem](#module\_instance-onprem) | git::https://github.com/stormreply/ssm-managed-instance.git | n/a |
| <a name="module_site"></a> [site](#module\_site) | ./site | n/a |

## Resources

| Name | Type |
|------|------|
| [aws\_customer\_gateway.onprem](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/customer_gateway) | resource |
| [aws\_eip.onprem](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip) | resource |
| [aws\_eip\_association.onprem](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip_association) | resource |
| [aws\_route.aws](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws\_route.onprem](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws\_vpn\_connection.vpn](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpn_connection) | resource |
| [aws\_vpn\_connection\_route.aws\_to\_onprem](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpn_connection_route) | resource |
| [aws\_vpn\_gateway.vgw](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpn_gateway) | resource |
| [local\_file.vpn\_config](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |
| [aws\_ami.latest\_ubuntu\_linux\_ami](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |
| [aws\_iam\_policy.amazon\_ssm\_managed\_instance\_core](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy) | data source |
| [cloudinit\_config.cgw](https://registry.terraform.io/providers/hashicorp/cloudinit/latest/docs/data-sources/config) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input__metadata"></a> [\_metadata](#input\_\_metadata) | Select metadata passed from GitHub Workflows | <pre>object({<br/>    actor      = string # Github actor (deployer) of the deployment<br/>    catalog_id = string # SLT catalog id of this module<br/>    deployment = string # slt-<catalod_id>-<repo>-<actor><br/>    ref        = string # Git reference of the deployment<br/>    ref_name   = string # Git ref_name (branch) of the deployment<br/>    repo       = string # GitHub short repository name (without owner) of the deployment<br/>    repository = string # GitHub full repository name (including owner) of the deployment<br/>    sha        = string # Git (full-length, 40 char) commit SHA of the deployment<br/>    short_name = string # slt-<catalog_id>-<actor><br/>    time       = string # Timestamp of the deployment<br/>  })</pre> | <pre>{<br/>  "actor": "",<br/>  "catalog_id": "",<br/>  "deployment": "",<br/>  "ref": "",<br/>  "ref_name": "",<br/>  "repo": "",<br/>  "repository": "",<br/>  "sha": "",<br/>  "short_name": "",<br/>  "time": ""<br/>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output__slt_config"></a> [\_slt\_config](#output\_\_slt\_config) | Map of SLT configuration |
| <a name="output_vpn_config"></a> [vpn\_config](#output\_vpn\_config) | n/a |
<!-- END_TF_DOCS -->

</details>

## Credits

- https://medium.com/@tanmaybhandge/aws-site-to-site-vpn-connection-using-strongswan-fb2f2f1b1f44
