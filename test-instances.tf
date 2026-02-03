module "instance-aws" {
  # tflint-ignore: terraform_module_pinned_source
  source                 = "git::https://github.com/stormreply/ssm-managed-instance.git"
  providers              = { aws = aws.aws-instance }
  region                 = local.sites.aws.region
  name                   = "${local._name_tag}-aws"
  instance_type          = "t3.small"
  policies               = [data.aws_iam_policy.amazon_ssm_managed_instance_core.arn]
  subnet_id              = module.site.aws.subnet.id
  vpc_security_group_ids = [module.site.aws.security-group.id]
  depends_on             = [aws_route.aws]
}

module "instance-onprem" {
  # tflint-ignore: terraform_module_pinned_source
  source                 = "git::https://github.com/stormreply/ssm-managed-instance.git"
  providers              = { aws = aws.onprem-instance }
  region                 = local.sites.onprem.region
  name                   = "${local._name_tag}-on-premises"
  instance_type          = "t3.small"
  policies               = [data.aws_iam_policy.amazon_ssm_managed_instance_core.arn]
  subnet_id              = module.site.onprem.subnet.id
  vpc_security_group_ids = [module.site.onprem.security-group.id]
  depends_on             = [aws_route.onprem]
}
