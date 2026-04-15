locals {
  sites = {
    aws = {
      name   = "aws"
      region = "eu-central-1"
      cidr   = "172.32.0.0/16"
      peer   = "onprem"
    }
    onprem = {
      name   = "on-premises"
      region = "eu-central-1"
      cidr   = "172.33.0.0/16"
      peer   = "aws"
    }
  }
}

module "site" {
  for_each = local.sites
  source   = "./site"
  name_tag = local._deployment
  site     = local.sites[each.key]
  peer     = local.sites[local.sites[each.key].peer]
}
