resource "aws_vpn_gateway" "vgw" {
  vpc_id = module.site.aws.vpc.id
  tags = {
    Name = local._deployment
  }
}
