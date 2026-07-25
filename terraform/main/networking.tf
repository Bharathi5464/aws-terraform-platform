# Create VPC
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr # VPC CIDR block
  enable_dns_support   = true         # Enable DNS resolution
  enable_dns_hostnames = true         # Enable DNS hostnames

  tags = merge(
    local.common_tags,
    {
      Name = "${local.project_name}-vpc"
    }
  )
}

# Create Public Subnets
resource "aws_subnet" "public" {

  count = length(var.public_subnet_cidrs) # Create one subnet for each CIDR block

  vpc_id                  = aws_vpc.main.id                      # VPC where the subnet will be created
  cidr_block              = var.public_subnet_cidrs[count.index] # Public subnet CIDR
  availability_zone       = var.availability_zones[count.index]  # Availability Zone
  map_public_ip_on_launch = true                                 # Assign public IP automatically

  tags = merge(
    local.common_tags,
    {
      Name = "${local.project_name}-public-subnet-${count.index + 1}"
      Type = "Public"
    }
  )
}

# Create Private Subnets
resource "aws_subnet" "private" {

  count = length(var.private_subnet_cidrs) # Create one subnet for each CIDR block

  vpc_id                  = aws_vpc.main.id                       # VPC where the subnet will be created
  cidr_block              = var.private_subnet_cidrs[count.index] # Private subnet CIDR
  availability_zone       = var.availability_zones[count.index]   # Availability Zone
  map_public_ip_on_launch = false                                 # Do not assign public IP

  tags = merge(
    local.common_tags,
    {
      Name = "${local.project_name}-private-subnet-${count.index + 1}"
      Type = "Private"
    }
  )
}

# Create Internet Gateway
resource "aws_internet_gateway" "main" {

  vpc_id = aws_vpc.main.id # Attach Internet Gateway to the VPC

  tags = merge(
    local.common_tags,
    {
      Name = "${local.project_name}-igw"
    }
  )
}

# Create Public Route Table
resource "aws_route_table" "public" {

  vpc_id = aws_vpc.main.id # Create route table in the VPC

  route {
    cidr_block = "0.0.0.0/0"                  # Route all internet traffic
    gateway_id = aws_internet_gateway.main.id # Send traffic to Internet Gateway
  }

  tags = merge(
    local.common_tags,
    {
      Name = "${local.project_name}-public-rt"
    }
  )
}

# Associate Public Route Table with Public Subnets
resource "aws_route_table_association" "public" {

  count = length(aws_subnet.public) # One association per public subnet

  subnet_id      = aws_subnet.public[count.index].id # Public subnet
  route_table_id = aws_route_table.public.id         # Public route table
}

# Create Private Route Table
resource "aws_route_table" "private" {

  vpc_id = aws_vpc.main.id # Create route table in the VPC

  tags = merge(
    local.common_tags,
    {
      Name = "${local.project_name}-private-rt"
    }
  )
}

# Associate Private Route Table with Private Subnets
resource "aws_route_table_association" "private" {

  count = length(aws_subnet.private) # One association per private subnet

  subnet_id      = aws_subnet.private[count.index].id # Private subnet
  route_table_id = aws_route_table.private.id         # Private route table
}