resource "aws_route" "aws" {
  region                 = local.sites["aws"].region
  route_table_id         = module.site.aws.route-table.id
  destination_cidr_block = local.sites["onprem"].cidr
  gateway_id             = aws_vpn_gateway.vgw.id
}
