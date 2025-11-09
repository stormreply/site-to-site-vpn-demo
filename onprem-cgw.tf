module "cgw" {
  source                 = "git::https://github.com/stormreply/ssm-managed-instance.git"
  region                 = local.sites["onprem"].region
  providers              = { aws = aws.cgw-instance }
  ami                    = data.aws_ami.latest_ubuntu_linux_ami.id
  name                   = "${local._name_tag}-cgw"
  instance_type          = "m6i.xlarge"
  policies               = [data.aws_iam_policy.amazon_ssm_managed_instance_core.arn]
  source_dest_check      = false
  subnet_id              = module.site.onprem.subnet.id
  vpc_security_group_ids = [module.site.onprem.security-group.id]
  user_data_base64       = base64encode(trimspace(data.cloudinit_config.cgw.rendered))
  # to make sure cgw instance starts after VPN
  depends_on = [
    aws_vpn_connection_route.aws_to_onprem,
    local_file.vpn_config
  ]
}
