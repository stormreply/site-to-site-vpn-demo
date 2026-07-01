# trivy:ignore:AVD-AWS-0099 (LOW): Security group explicitly uses the default description.
# trivy:ignore:AVD-AWS-0104 (CRITICAL): Security group rule allows unrestricted egress to any IP address.
resource "aws_security_group" "this" {
  # checkov:skip=CKV_AWS_382: "Ensure no security groups allow egress from 0.0.0.0:0 to port -1"
  # checkov:skip=CKV2_AWS_5: "Ensure that Security Groups are attached to another resource"
  region      = var.site.region
  name        = "${var.name_tag}-${var.site.name}"
  vpc_id      = aws_vpc.this.id
  description = "Security group to be used with instances. Passed as output."

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
