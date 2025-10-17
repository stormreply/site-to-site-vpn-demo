resource "aws_vpn_connection" "vpn" {
  customer_gateway_id = aws_customer_gateway.onprem.id
  # local_ipv4_network_cidr  = local.sites.aws.cidr
  # remote_ipv4_network_cidr = local.sites.onprem.cidr
  static_routes_only = true
  type               = "ipsec.1"
  tags = {
    Name = local._deployment
  }
  # important - VPN connection won't work othw
  depends_on = [
    aws_vpn_gateway.vgw
  ]
}

resource "aws_vpn_connection_route" "aws_to_onprem" {
  vpn_connection_id      = aws_vpn_connection.vpn.id
  destination_cidr_block = local.sites.onprem.cidr
}

resource "local_file" "vpn_config" {
  content  = nonsensitive(aws_vpn_connection.vpn.customer_gateway_configuration)
  filename = "${path.module}/vpn-config.xml"
}
