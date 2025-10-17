module "instance-aws" {
  source                 = "git::https://github.com/stormreply/terraform-build-controller.git"
  providers              = { aws = aws.aws-instance }
  region                 = local.sites.aws.region
  instance_name          = "${local._deployment}-aws"
  instance_type          = "t3.small"
  policies               = [data.aws_iam_policy.amazon_ssm_managed_instance_core.arn]
  subnet_id              = module.site.aws.subnet.id
  vpc_security_group_ids = [module.site.aws.security-group.id]
  depends_on             = [aws_route.aws]
}

module "instance-onprem" {
  source                 = "git::https://github.com/stormreply/terraform-build-controller.git"
  providers              = { aws = aws.onprem-instance }
  region                 = local.sites.onprem.region
  instance_name          = "${local._deployment}-onprem"
  instance_type          = "t3.small"
  policies               = [data.aws_iam_policy.amazon_ssm_managed_instance_core.arn]
  subnet_id              = module.site.onprem.subnet.id
  vpc_security_group_ids = [module.site.onprem.security-group.id]
  depends_on             = [aws_route.onprem]
}

# can't iterate bc/o providers not being iterable
# module "test-instance" {
#   for_each               = local.sites
#   source                 = "git::https://github.com/stormreply/terraform-build-controller.git"
#   region                 = each.value.region
#   instance_name          = "${local._deployment}-${each.key}"
#   instance_type          = "t3.small"
#   policies               = [data.aws_iam_policy.amazon_ssm_managed_instance_core.arn]
#   subnet_id              = module.site[each.key].subnet.id
#   vpc_security_group_ids = [module.site[each.key].security-group.id]
#   depends_on             = [aws_route.aws, aws_route.onprem]
# }
