module "cgw" {
  # checkov:skip=CKV_TF_1: "Ensure Terraform module sources use a commit hash"
  # checkov:skip=CKV_TF_2: "Ensure Terraform module sources use a tag with a version number"
  # tflint-ignore: terraform_module_pinned_source
  source                 = "git::https://github.com/stormreply/ssm-managed-instance.git"
  region                 = local.sites["onprem"].region
  ami                    = data.aws_ami.latest_ubuntu_linux_ami.id
  name                   = "${local._deployment}-cgw"
  instance_type          = "m6i.xlarge"
  policies               = [data.aws_iam_policy.amazon_ssm_managed_instance_core.arn]
  source_dest_check      = false
  subnet_id              = module.site.onprem.subnet.id
  vpc_security_group_ids = [module.site.onprem.security-group.id]
  user_data_base64       = base64encode(trimspace(data.cloudinit_config.cgw.rendered))
  dependencies = [
    jsonencode(aws_vpn_connection_route.aws_to_onprem),
    jsonencode(local_file.vpn_config)
  ]
}
