data "aws_ami" "latest_ubuntu_linux_ami" {
  most_recent = true
  owners      = ["amazon"]
  region      = local.sites["onprem"].region
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server*"]
    # e.g. al2023-ami-2023.3.20231218.0-kernel-6.1-x86_64
  }
  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}
