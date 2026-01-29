locals {
  sites = {
    aws = {
      name   = "aws"
      region = "eu-central-1"
      cidr   = "172.32.0.0/16"
    }
    onprem = {
      name   = "on-premises"
      region = "eu-central-1"
      cidr   = "172.33.0.0/16"
    }
  }
}

module "site" {
  for_each = local.sites
  source   = "./site"
  name_tag = local._name_tag
  site     = local.sites[each.key]
}
