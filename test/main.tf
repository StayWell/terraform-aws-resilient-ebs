provider "aws" {
  region = "us-east-1"
}

data "aws_availability_zones" "this" {}

module "this" {
  source            = "../"
  availability_zone = data.aws_availability_zones.this.names[1]
}
