# Configure the AWS provider
provider "aws" {

  region = var.aws_region # AWS region for resource deployment
  default_tags {
    tags = local.common_tags
  }
}