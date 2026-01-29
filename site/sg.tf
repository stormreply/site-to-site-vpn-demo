resource "aws_security_group" "this" {
  region = var.site.region
  name   = "${var.name_tag}-${var.site.name}"
  vpc_id = aws_vpc.this.id

  # ingress {
  #   from_port = 0
  #   to_port   = 0
  #   protocol  = "-1"
  #   self      = true
  # }

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.site.cidr, var.peer.cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.name_tag}-${var.site.name}"
  }
}
