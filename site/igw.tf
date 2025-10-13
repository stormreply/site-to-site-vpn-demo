resource "aws_internet_gateway" "this" {
  region = var.site.region
  vpc_id = aws_vpc.this.id
  tags = {
    Name = "${var.deployment.name}-${var.site.name}"
  }
}
