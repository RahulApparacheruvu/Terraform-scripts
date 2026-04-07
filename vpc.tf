#-----------------------------------------
# VPC 1
#-----------------------------------------
resource "aws_vpc" "vpc1" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = { Name = "VPC-1" }
}

resource "aws_subnet" "vpc1_public" {
  vpc_id                  = aws_vpc.vpc1.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-central-1a"
  map_public_ip_on_launch = true
  tags = { Name = "VPC1-Public-Subnet" }
}

resource "aws_subnet" "vpc1_private" {
  vpc_id            = aws_vpc.vpc1.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-central-1b"
  tags = { Name = "VPC1-Private-Subnet" }
}

#-----------------------------------------
# VPC 2
#-----------------------------------------
resource "aws_vpc" "vpc2" {
  cidr_block           = "20.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = { Name = "VPC-2" }
}

resource "aws_subnet" "vpc2_public" {
  vpc_id                  = aws_vpc.vpc2.id
  cidr_block              = "20.0.1.0/24"
  availability_zone       = "us-central-1a"
  map_public_ip_on_launch = true
  tags = { Name = "VPC2-Public-Subnet" }
}

resource "aws_subnet" "vpc2_private" {
  vpc_id            = aws_vpc.vpc2.id
  cidr_block        = "20.0.2.0/24"
  availability_zone = "us-central-1b"
  tags = { Name = "VPC2-Private-Subnet" }
}