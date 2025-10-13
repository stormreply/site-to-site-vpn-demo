locals {
  sites = {
    aws = {
      name   = "aws"
      region = "eu-central-1"
      cidr   = "172.31.0.0/16"
    }
    onprem = {
      name   = "onprem"
      region = "eu-west-1"
      cidr   = "172.32.0.0/16"
    }
  }
}

module "site" {
  for_each   = local.sites
  source     = "./site"
  deployment = local.deployment
  site       = local.sites[each.key]
}
