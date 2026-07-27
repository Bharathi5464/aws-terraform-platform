# Create a Security Group
resource "aws_security_group" "web_sg" {

  name        = "web-security-group"                          # Name shown in AWS Console
  description = "Security group for TaskFlow web application" # Purpose of this Security Group
  vpc_id      = aws_vpc.main.id                               # Attach this Security Group to our VPC

  ingress {
    description = "Allow SSH"          # Rule description
    from_port   = 22                   # Start port
    to_port     = 22                   # End port
    protocol    = "tcp"                # SSH uses TCP
    cidr_blocks = [var.ssh_allowed_ip] # Allow SSH from anywhere (Learning only - Production: use Your_IP/32)
  }

  ingress {
    description = "Allow HTTP"  # Rule description
    from_port   = 80            # HTTP port
    to_port     = 80            # HTTP port
    protocol    = "tcp"         # HTTP uses TCP
    cidr_blocks = ["0.0.0.0/0"] # Allow everyone to access the website
  }

  ingress {
    description = "Allow HTTPS" # Rule description
    from_port   = 443           # HTTPS port
    to_port     = 443           # HTTPS port
    protocol    = "tcp"         # HTTPS uses TCP
    cidr_blocks = ["0.0.0.0/0"] # Allow everyone to access the secure website
  }

  egress {
    description = "Allow all outbound traffic" # Outbound rule description
    from_port   = 0                            # Start from all ports
    to_port     = 0                            # End at all ports
    protocol    = "-1"                         # -1 means all protocols (TCP, UDP, ICMP, etc.)
    cidr_blocks = ["0.0.0.0/0"]                # Allow EC2 to connect anywhere on the Internet
  }

# Fix — add merge like every other resource
tags = merge(
  local.common_tags,
  {
    Name = "${local.project_name}-sg"
  }
)