resource "aws_customer_gateway" "onprem" {
  bgp_asn    = 65000
  ip_address = aws_eip.onprem.public_ip
  type       = "ipsec.1"
  tags = {
    Name = local._name_tag
  }
}
