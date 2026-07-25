# AWS Region variable
variable "aws_region" {
  description = "AWS Region where resources will be created" # AWS Region
  type        = string                                       # Variable data type
}

# Deployment environment variable
variable "environment" {
  description = "Deployment environment (dev, test, prod)" # Environment name
  type        = string                                     # Variable data type
}

# Project name variable
variable "project_name" {
  description = "Project name" # Project name
  type        = string         # Variable data type
}

# VPC CIDR block variable
variable "vpc_cidr" {
  description = "CIDR block for the VPC" # VPC network range
  type        = string                   # Variable data type
}

# Availability Zones variable
variable "availability_zones" {
  description = "Availability Zones for subnets" # Availability Zones
  type        = list(string)                     # List of strings

  default = [
    "ap-south-1a", # Availability Zone 1
    "ap-south-1b"  # Availability Zone 2
  ]
}

# Public subnet CIDR blocks
variable "public_subnet_cidrs" {
  description = "CIDR blocks for public subnets" # Public subnet ranges
  type        = list(string)                     # List of strings

  default = [
    "10.0.1.0/24", # Public Subnet 1
    "10.0.2.0/24"  # Public Subnet 2
  ]
}

# Private subnet CIDR blocks
variable "private_subnet_cidrs" {
  description = "CIDR blocks for private subnets" # Private subnet ranges
  type        = list(string)                      # List of strings

  default = [
    "10.0.11.0/24", # Private Subnet 1
    "10.0.12.0/24"  # Private Subnet 2
  ]
}