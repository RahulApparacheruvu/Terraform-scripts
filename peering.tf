resource "aws_vpc_peering_connection" "VPC1-VPC2" {
    vpc_id = "aws_vpc.vpc1.id"
    peer_vpc_id = "aws_vpc.vpc2.id"
    auto_accept = "true"
    tags = {
        Name = "VPC1-VPC2 Peering"
    }
}