provider "aws" {
  default_tags {
    tags = local._default_tags
  }
}

provider "aws" {
  alias = "cgw-instance"
  default_tags {
    tags = merge(
      local._default_tags,
      {
        deployment-name = "${local._deployment}-cgw"
      }
    )
  }
}

provider "aws" {
  alias = "aws-instance"
  default_tags {
    tags = merge(
      local._default_tags,
      {
        deployment-name = "${local._deployment}-aws"
      }
    )
  }
}

provider "aws" {
  alias = "onprem-instance"
  default_tags {
    tags = merge(
      local._default_tags,
      {
        deployment-name = "${local._deployment}-onprem"
      }
    )
  }
}
