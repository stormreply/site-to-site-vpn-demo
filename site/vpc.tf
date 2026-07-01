resource "aws_vpc" "this" {
  # checkov:skip=CKV2_AWS_11: "Ensure VPC flow logging is enabled in all VPCs"
  # checkov:skip=CKV2_AWS_12: "Ensure the default security group of every VPC restricts all traffic"
  region     = var.site.region
  cidr_block = var.site.cidr
  tags = {
    Name = "${var.name_tag}-${var.site.name}"
  }
}
