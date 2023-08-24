provider "aws" {
  region = var.region
  default_tags {
    tags = {
      project   = local.project
      terraform = "1"
    }
  }
}
