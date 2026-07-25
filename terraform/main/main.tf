resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"          # VPC IP address range
  enable_dns_support   = true                   # Enable DNS resolution
  enable_dns_hostnames = true                   # Enable DNS hostnames for instances

  tags = merge(                                 # Merge common and custom tags
    local.common_tags,
    {
      Name = "${local.project_name}-vpc"        # VPC name
    }
  )
}