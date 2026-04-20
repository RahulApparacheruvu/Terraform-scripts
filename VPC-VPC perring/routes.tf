#-----------------------------------------
# VPC1 - Public Route Table
#-----------------------------------------
resource "aws_route_table" "vpc1_public_rt" {
  vpc_id = aws_vpc.vpc1.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw1.id
  }

  route {
    cidr_block                = "20.0.0.0/16"
    vpc_peering_connection_id = aws_vpc_peering_connection.vpc1_vpc2.id
  }

  tags = { Name = "VPC1-Public-RT" }
}

resource "aws_route_table_association" "vpc1_public_assoc" {
  subnet_id      = aws_subnet.vpc1_public.id
  route_table_id = aws_route_table.vpc1_public_rt.id
}

#-----------------------------------------
# VPC1 - Private Route Table
#-----------------------------------------
resource "aws_route_table" "vpc1_private_rt" {
  vpc_id = aws_vpc.vpc1.id

  route {
    cidr_block                = "20.0.0.0/16"
    vpc_peering_connection_id = aws_vpc_peering_connection.vpc1_vpc2.id
  }

  tags = { Name = "VPC1-Private-RT" }
}

resource "aws_route_table_association" "vpc1_private_assoc" {
  subnet_id      = aws_subnet.vpc1_private.id
  route_table_id = aws_route_table.vpc1_private_rt.id
}

#-----------------------------------------
# VPC2 - Public Route Table
#-----------------------------------------
resource "aws_route_table" "vpc2_public_rt" {
  vpc_id = aws_vpc.vpc2.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw2.id
  }

  route {
    cidr_block                = "10.0.0.0/16"
    vpc_peering_connection_id = aws_vpc_peering_connection.vpc1_vpc2.id
  }

  tags = { Name = "VPC2-Public-RT" }
}

resource "aws_route_table_association" "vpc2_public_assoc" {
  subnet_id      = aws_subnet.vpc2_public.id
  route_table_id = aws_route_table.vpc2_public_rt.id
}

#-----------------------------------------
# VPC2 - Private Route Table
#-----------------------------------------
resource "aws_route_table" "vpc2_private_rt" {
  vpc_id = aws_vpc.vpc2.id

  route {
    cidr_block                = "10.0.0.0/16"
    vpc_peering_connection_id = aws_vpc_peering_connection.vpc1_vpc2.id
  }

  tags = { Name = "VPC2-Private-RT" }
}

resource "aws_route_table_association" "vpc2_private_assoc" {
  subnet_id      = aws_subnet.vpc2_private.id
  route_table_id = aws_route_table.vpc2_private_rt.id
}