terraform {
  # Specify the minimum Terraform version required
  required_version = ">= 1.15.0"
  # Define the required providers
  required_providers {
    # AWS provider configuration
    aws = {
      # Provider source
      source = "hashicorp/aws"
      # AWS provider version
      version = "~> 6.0"
    }
  }
}