# trivy:ignore:AVD-AWS-0099 (LOW): Security group explicitly uses the default description.
# trivy:ignore:AVD-AWS-0104 (CRITICAL): Security group rule allows unrestricted egress to any IP address.
resource "aws_security_group" "this" {
  region = var.site.region
  name   = "${var.name_tag}-${var.site.name}"
  vpc_id = aws_vpc.this.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.site.cidr, var.peer.cidr]
    description = "allow ingress on all ports from peers"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "allow egress to everywhere"
  }

  tags = {
    Name = "${var.name_tag}-${var.site.name}"
  }
}
