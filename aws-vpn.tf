resource "aws_vpn_connection" "vpn" {
  vpn_gateway_id      = aws_vpn_gateway.vgw.id
  customer_gateway_id = aws_customer_gateway.onprem.id
  type                = "ipsec.1"
  static_routes_only  = true
  tags = {
    Name = local._deployment
  }
}

resource "aws_vpn_connection_route" "aws_to_onprem" {
  vpn_connection_id      = aws_vpn_connection.vpn.id
  destination_cidr_block = local.sites["onprem"].cidr
}

resource "local_file" "vpn_config" {
  content  = nonsensitive(aws_vpn_connection.vpn.customer_gateway_configuration)
  filename = "${path.module}/vpn-config.xml"
}
