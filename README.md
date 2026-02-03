# site-to-site-vpn

A demo simulating a site-to-site VPN between on-prem and AWS, using a StrongSwan instance as Customer Gateway

#### Storm Library for Terraform

This repository is a member of the SLT | Storm Library for Terraform,
a collection of Terraform modules for Amazon Web Services. The focus
of these modules, maintained in separate GitHub™ repositories, is on
building examples, demos and showcases on AWS. The audience of the
library is learners and presenters alike - people that want to know
or show how a certain service, pattern or solution looks like, or "feels".

[Learn more](https://github.com/stormreply/storm-library-for-terraform)

<details>
<summary>Klicke zum Anzeigen</summary>

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 6.30.0 |
| <a name="requirement_cloudinit"></a> [cloudinit](#requirement\_cloudinit) | 2.3.7 |
| <a name="requirement_local"></a> [local](#requirement\_local) | 2.6.2 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 6.30.0 |
| <a name="provider_cloudinit"></a> [cloudinit](#provider\_cloudinit) | 2.3.7 |
| <a name="provider_local"></a> [local](#provider\_local) | 2.6.2 |

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
| [aws_customer_gateway.onprem](https://registry.terraform.io/providers/hashicorp/aws/6.30.0/docs/resources/customer_gateway) | resource |
| [aws_eip.onprem](https://registry.terraform.io/providers/hashicorp/aws/6.30.0/docs/resources/eip) | resource |
| [aws_eip_association.onprem](https://registry.terraform.io/providers/hashicorp/aws/6.30.0/docs/resources/eip_association) | resource |
| [aws_route.aws](https://registry.terraform.io/providers/hashicorp/aws/6.30.0/docs/resources/route) | resource |
| [aws_route.onprem](https://registry.terraform.io/providers/hashicorp/aws/6.30.0/docs/resources/route) | resource |
| [aws_vpn_connection.vpn](https://registry.terraform.io/providers/hashicorp/aws/6.30.0/docs/resources/vpn_connection) | resource |
| [aws_vpn_connection_route.aws_to_onprem](https://registry.terraform.io/providers/hashicorp/aws/6.30.0/docs/resources/vpn_connection_route) | resource |
| [aws_vpn_gateway.vgw](https://registry.terraform.io/providers/hashicorp/aws/6.30.0/docs/resources/vpn_gateway) | resource |
| [local_file.vpn_config](https://registry.terraform.io/providers/hashicorp/local/2.6.2/docs/resources/file) | resource |
| [aws_ami.latest_ubuntu_linux_ami](https://registry.terraform.io/providers/hashicorp/aws/6.30.0/docs/data-sources/ami) | data source |
| [aws_iam_policy.amazon_ssm_managed_instance_core](https://registry.terraform.io/providers/hashicorp/aws/6.30.0/docs/data-sources/iam_policy) | data source |
| [cloudinit_config.cgw](https://registry.terraform.io/providers/hashicorp/cloudinit/2.3.7/docs/data-sources/config) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input__metadata"></a> [\_metadata](#input\_\_metadata) | n/a | <pre>object({<br/>    actor      = string # Github actor (deployer) of the deployment<br/>    catalog_id = string # SLT catalog id of this module<br/>    deployment = string # slt-<catalod_id>-<repo>-<actor><br/>    ref        = string # Git reference of the deployment<br/>    ref_name   = string # Git ref_name (branch) of the deployment<br/>    repo       = string # GitHub short repository name (without owner) of the deployment<br/>    repository = string # GitHub full repository name (including owner) of the deployment<br/>    sha        = string # Git (full-length, 40 char) commit SHA of the deployment<br/>    short_name = string # slt-<catalog_id>-<actor><br/>    time       = string # Timestamp of the deployment<br/>  })</pre> | <pre>{<br/>  "actor": "",<br/>  "catalog_id": "",<br/>  "deployment": "",<br/>  "ref": "",<br/>  "ref_name": "",<br/>  "repo": "",<br/>  "repository": "",<br/>  "sha": "",<br/>  "short_name": "",<br/>  "time": ""<br/>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output__default_tags"></a> [\_default\_tags](#output\_\_default\_tags) | n/a |
| <a name="output__metadata"></a> [\_metadata](#output\_\_metadata) | n/a |
| <a name="output__name_tag"></a> [\_name\_tag](#output\_\_name\_tag) | n/a |
| <a name="output_vpn_config"></a> [vpn\_config](#output\_vpn\_config) | n/a |
<!-- END_TF_DOCS -->

</details>

#### Credits

- https://medium.com/@tanmaybhandge/aws-site-to-site-vpn-connection-using-strongswan-fb2f2f1b1f44
