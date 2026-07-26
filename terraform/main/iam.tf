# Create IAM Role for EC2
resource "aws_iam_role" "ec2_role" {

  name = "${local.project_name}-ec2-role" # Name of the IAM Role created in AWS
  assume_role_policy = jsonencode({       # Convert the IAM trust policy from Terraform format to JSON

    Version = "2012-10-17" # IAM policy language version (AWS standard)
    Statement = [
      {
        Effect = "Allow" # Allow the specified action
        Principal = {
          Service = "ec2.amazonaws.com" # Allow the EC2 service to assume this role
        }
        Action = "sts:AssumeRole" # Permission that allows EC2 to assume (use) this IAM Role
      }
    ]
  })

  tags = merge(        # Merge common tags with resource-specific tags
    local.common_tags, # Common tags shared across all resources
    {
      Name = "${local.project_name}-ec2-role" # Name tag displayed in the AWS Console
    }
  )
}
# Create IAM Instance Profile for EC2
resource "aws_iam_instance_profile" "ec2_profile" {

  name = "${local.project_name}-ec2-profile" # Name of the IAM Instance Profile created in AWS

  role = aws_iam_role.ec2_role.name # Attach the IAM Role to this Instance Profile
}
# Attach Amazon ECR Read-Only policy to the IAM Role
resource "aws_iam_role_policy_attachment" "ecr_readonly" {
  role = aws_iam_role.ec2_role.name
  # AWS managed policy that allows EC2 to pull images from Amazon ECR
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

