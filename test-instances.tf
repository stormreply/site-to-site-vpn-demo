module "instance-aws" {
  # checkov:skip=CKV_TF_1: "Ensure Terraform module sources use a commit hash"
  # checkov:skip=CKV_TF_2: "Ensure Terraform module sources use a tag with a version number"
  # tflint-ignore: terraform_module_pinned_source
  source                 = "git::https://github.com/stormreply/ssm-managed-instance.git"
  region                 = local.sites.aws.region
  name                   = "${local._deployment}-aws"
  instance_type          = "t3.small"
  policies               = [data.aws_iam_policy.amazon_ssm_managed_instance_core.arn]
  subnet_id              = module.site.aws.subnet.id
  vpc_security_group_ids = [module.site.aws.security-group.id]
  dependencies           = [jsonencode(aws_route.aws)]
}

module "instance-onprem" {
  # checkov:skip=CKV_TF_1: "Ensure Terraform module sources use a commit hash"
  # checkov:skip=CKV_TF_2: "Ensure Terraform module sources use a tag with a version number"
  # tflint-ignore: terraform_module_pinned_source
  source                 = "git::https://github.com/stormreply/ssm-managed-instance.git"
  region                 = local.sites.onprem.region
  name                   = "${local._deployment}-on-premises"
  instance_type          = "t3.small"
  policies               = [data.aws_iam_policy.amazon_ssm_managed_instance_core.arn]
  subnet_id              = module.site.onprem.subnet.id
  vpc_security_group_ids = [module.site.onprem.security-group.id]
  dependencies           = [jsonencode(aws_route.onprem)]
}
