resource "aws_route_table" "this" {
  region = var.site.region
  vpc_id = aws_vpc.this.id
  tags = {
    Name = "${var.deployment.name}-${var.site.name}"
  }
}

resource "aws_route" "default" {
  region                 = var.site.region
  route_table_id         = aws_route_table.this.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.this.id
}

resource "aws_route_table_association" "default" {
  region         = var.site.region
  subnet_id      = aws_subnet.this.id
  route_table_id = aws_route_table.this.id
}
