data "cloudinit_config" "cgw" {

  # see https://discuss.hashicorp.com/t/terraform-template-cloudinit-config-multiple-part-execution-order-is-wrong/16962/3
  gzip          = false
  base64_encode = false

  part {
    filename     = "01-install-dependencies.sh"
    content_type = "text/x-shellscript"
    content      = file("${path.module}/scripts/01-install-dependencies.sh")
  }

  part {
    filename     = "02-cloud-config.yaml"
    content_type = "text/cloud-config"
    content      = <<-EOT
      #cloud-config
      write_files:
        - path: /etc/ipsec.d/aws-updown.sh
          permissions: '0744'
          owner: root:root
          encoding: b64
          content: ${base64encode(file("${path.module}/scripts/02-aws-updown.sh"))}
        - path: /vpn-config.xml
          permissions: '0400'
          owner: root:root
          encoding: b64
          content: ${base64encode(nonsensitive(aws_vpn_connection.vpn.customer_gateway_configuration))}
    EOT
  }


  part {
    filename     = "04-configure-vpn-tunnels.sh"
    content_type = "text/x-shellscript"
    content = templatefile("${path.module}/scripts/04-configure-vpn-tunnels.sh", {
      cidr_aws    = local.sites.aws.cidr
      cidr_onprem = local.sites.onprem.cidr
    })
  }
}
