resource "aws_eip" "onprem" {
  region     = local.sites["onprem"].region
  domain     = "vpc"
  depends_on = [module.site.onprem] # cf. aws_eip doc
  tags = {
    Name = "${local._deployment}-cgw"
  }
}

resource "aws_eip_association" "onprem" {
  region        = local.sites["onprem"].region
  instance_id   = module.cgw.instance.id
  allocation_id = aws_eip.onprem.id
}
