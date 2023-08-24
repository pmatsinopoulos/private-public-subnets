provider "aws" {
  region = local.region
  default_tags {
    tags = {
      project   = local.project
      terraform = "1"
    }
  }
}
