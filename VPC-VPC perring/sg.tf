#-----------------------------------------
# SG for EC2 in VPC1 Public Subnet
#-----------------------------------------
resource "aws_security_group" "vpc1_sg" {
  vpc_id = aws_vpc.vpc1.id
  name   = "VPC1-EC2-SG"

  # SSH from internet
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Ping from VPC2
  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["20.0.0.0/16"]
  }

  # All outbound allowed
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = "VPC1-SG" }
}

#-----------------------------------------
# SG for EC2 in VPC2 Private Subnet
#-----------------------------------------
resource "aws_security_group" "vpc2_sg" {
  vpc_id = aws_vpc.vpc2.id
  name   = "VPC2-EC2-SG"

  # SSH only from VPC1
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }

  # Ping only from VPC1
  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["10.0.0.0/16"]
  }

  # All outbound allowed
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = "VPC2-SG" }
}