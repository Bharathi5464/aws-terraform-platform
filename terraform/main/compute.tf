# Get the latest available Amazon Linux 2023 AMI
data "aws_ami" "amazon_linux" {
  most_recent = true       # Select the latest matching AMI
  owners      = ["amazon"] # Search only official AWS-published AMIs

  filter {
    name   = "name"                  # Filter by AMI name
    values = ["al2023-ami-*-x86_64"] # Match Amazon Linux 2023 (64-bit)
  }

  filter {
    name   = "state"       # Filter by AMI state
    values = ["available"] # Only use available AMIs
  }
}
# Create AWS Key Pair
resource "aws_key_pair" "main" {
  key_name   = "${local.project_name}-key"                   # Name of the key pair that will be created in AWS
  public_key = file("~/.ssh/aws-terraform-platform-key.pub") # Read the public key from the local .pub file
  tags = merge(                                              # Merge common tags with resource-specific tags
    local.common_tags,                                       # Common tags shared across all resources
    {
      Name = "${local.project_name}-key" # Name tag displayed in the AWS Console
    }
  )
}
# Create EC2 Instance
resource "aws_instance" "app_server" {

  ami                    = data.aws_ami.amazon_linux.id              # Use the latest Amazon Linux 2023 AMI from the data source
  instance_type          = "t3.micro"                                # Launch a t3.micro EC2 instance
  subnet_id              = aws_subnet.public[0].id                   # Launch the EC2 in the first public subnet
  vpc_security_group_ids = [aws_security_group.web_sg.id]            # Attach the web Security Group to the EC2 instance
  iam_instance_profile   = aws_iam_instance_profile.ec2_profile.name # Attach IAM Role to EC2
  key_name               = aws_key_pair.main.key_name                # Attach the AWS Key Pair for SSH access
  tags = merge(                                                      # Merge common tags with resource-specific tags
    local.common_tags,                                               # Common tags shared across all resources
    {
      Name = "${local.project_name}-ec2" # Name tag displayed in the AWS Console
    }
  )
}