output "ec2_vpc1_public_ip" {
  description = "Public IP of EC2 in VPC1"
  value       = aws_instance.ec2_vpc1.public_ip
}

output "ec2_vpc2_private_ip" {
  description = "Private IP of EC2 in VPC2"
  value       = aws_instance.ec2_vpc2.private_ip
}

output "vpc_peering_id" {
  description = "VPC Peering Connection ID"
  value       = aws_vpc_peering_connection.vpc1_vpc2.id
}