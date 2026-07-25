locals {
  project_name = var.project_name # Store the project name locally

  common_tags = {
    Project     = local.project_name # Project tag
    Environment = var.environment    # Environment tag
    ManagedBy   = "Terraform"        # Indicates Terraform manages the resource
  }
}