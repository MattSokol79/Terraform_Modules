# Provides the VPC ID to other modules
output "vpc_id" {
    value = aws_vpc.matt_vpc.id
}

# Provides the Public Subnet ID to other modules
output "public_subnet_id" {
    value = aws_subnet.public_subnet.id
}

# Provides the Private Subnet ID to other modules
output "private_subnet_id" {
    value = aws_subnet.private_subnet.id
}