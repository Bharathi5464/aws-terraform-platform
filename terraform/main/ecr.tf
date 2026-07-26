# Create an Amazon Elastic Container Registry (ECR) Repository
resource "aws_ecr_repository" "taskflow" {

  name = "${local.project_name}-taskflow" # Name of the ECR repository in AWS

  image_tag_mutability = "MUTABLE" # Allow image tags (e.g., latest, v1) to be overwritten

  image_scanning_configuration {
    scan_on_push = true # Automatically scan Docker images for vulnerabilities when pushed
  }

  tags = merge(        # Merge common tags with resource-specific tags
    local.common_tags, # Common tags shared across all resources
    {
      Name = "${local.project_name}-ecr" # Name tag displayed in the AWS Console
    }
  )
}