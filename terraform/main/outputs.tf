output "vpc_id" {
  description = "ID of the created VPC" # Description shown when viewing Terraform outputs
  value       = aws_vpc.main.id         # Output the ID of the created VPC
}

output "public_subnet_ids" {
  description = "IDs of public subnets" # Description for public subnet IDs
  value       = aws_subnet.public[*].id # Output IDs of all public subnets using splat expression
}

output "private_subnet_ids" {
  description = "IDs of private subnets" # Description for private subnet IDs
  value       = aws_subnet.private[*].id # Output IDs of all private subnets using splat expression
}

output "ec2_public_ip" {
  description = "Public IP address of EC2 instance" # Description for EC2 public IP
  value       = aws_instance.app_server.public_ip   # Output the public IP assigned to the EC2 instance
}

output "ec2_public_dns" {
  description = "Public DNS of EC2 instance"       # Description for EC2 public DNS name
  value       = aws_instance.app_server.public_dns # Output the public DNS address of the EC2 instance
}