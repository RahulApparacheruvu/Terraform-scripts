# EC2 in VPC1 - Public Subnet
resource "aws_instance" "ec2_vpc1" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.vpc1_public.id
  vpc_security_group_ids = [aws_security_group.vpc1_sg.id]
  key_name               = var.key_pair_name

  tags = { Name = "EC2-VPC1-Public" }
}

# EC2 in VPC2 - Private Subnet
resource "aws_instance" "ec2_vpc2" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.vpc2_private.id
  vpc_security_group_ids = [aws_security_group.vpc2_sg.id]
  key_name               = var.key_pair_name

  tags = { Name = "EC2-VPC2-Private" }
}