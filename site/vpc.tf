resource "aws_vpc" "this" {
  region     = var.site.region
  cidr_block = var.site.cidr
  tags = {
    Name = "${var.name_tag}-${var.site.name}"
  }
}
