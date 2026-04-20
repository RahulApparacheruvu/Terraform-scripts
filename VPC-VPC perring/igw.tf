#IGW for vpc1
resource "aws_internet_gateway" "igw1"{
    vpc_id = aws_vpc.vpc1.id
    tags = {
        Name = "IGW-1"
    }
}

#IGW for vpc2
resource "aws_internet_gateway" "igw2"{
    vpc_id = aws_vpc.vpc2.id
    tags = {
        Name = "IGW-2"
    }
}