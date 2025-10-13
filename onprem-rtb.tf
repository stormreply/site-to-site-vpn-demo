resource "aws_route" "onprem" {
  region                 = local.sites["onprem"].region
  route_table_id         = module.site.onprem.route-table.id
  destination_cidr_block = local.sites["aws"].cidr
  network_interface_id   = module.cgw.instance.primary_network_interface_id
}
