locals {
  _metadata = merge(
    var._metadata,
    var._metadata.deployment == "" ? { deployment = basename(abspath(path.module)) } : {},
    var._metadata.short_name == "" ? { short_name = basename(abspath(path.module)) } : {}
  )
}

locals {
  _deployment = local._metadata.deployment
}

variable "_metadata" {
  type = object({
    actor       = string # Github actor (deployer) of the deployment
    catalog_id  = string # SLT catalog id of this module
    environment = string # environment of the deployment, defaults to <actor>
    deployment  = string # slt-<catalod_id>-<repo>-<environment>
    ref         = string # Git reference of the deployment
    ref_name    = string # Git ref_name (branch) of the deployment
    repo        = string # GitHub short repository name (without owner) of the deployment
    repository  = string # GitHub full repository name (including owner) of the deployment
    sha         = string # Git (full-length, 40 char) commit SHA of the deployment
    short_name  = string # slt-<cat>-<environment>
    time        = string # Timestamp of the deployment
  })
  default = {
    actor       = ""
    catalog_id  = ""
    environment = ""
    deployment  = ""
    ref         = ""
    ref_name    = ""
    repo        = ""
    repository  = ""
    sha         = ""
    short_name  = ""
    time        = ""
  }
}

output "_deployment" {
  value = local._deployment

}

output "_metadata" {
  value = var._metadata
}
