module "test-instance" {
  for_each               = local.sites
  source                 = "git::https://github.com/stormreply/terraform-build-controller.git"
  region                 = each.value.region
  deployment             = local.deployment
  instance_name          = "${local.deployment.name}-${each.key}"
  instance_type          = "t3.small"
  policies               = [data.aws_iam_policy.amazon_ssm_managed_instance_core.arn]
  subnet_id              = module.site[each.key].subnet.id
  vpc_security_group_ids = [module.site[each.key].security-group.id]
  depends_on             = [aws_route.aws, aws_route.onprem]
}
