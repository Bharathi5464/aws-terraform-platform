# Configure the AWS provider
provider "aws" {

  region = var.aws_region # AWS region for resource deployment

  default_tags { # Apply default tags to all AWS resources
    tags = {

      Project = local.project_name # Project name

      Environment = var.environment # Deployment environment

      ManagedBy = "Terraform" # Resource management tool
    }
  }
}