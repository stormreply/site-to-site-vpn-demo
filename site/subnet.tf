resource "aws_subnet" "this" {
  region                  = var.site.region
  vpc_id                  = aws_vpc.this.id
  cidr_block              = cidrsubnet(var.site.cidr, 8, 1)
  map_public_ip_on_launch = true
  availability_zone       = "${var.site.region}a"
  tags = {
    Name = "${var.name_tag}-${var.site.name}-public"
  }
}
