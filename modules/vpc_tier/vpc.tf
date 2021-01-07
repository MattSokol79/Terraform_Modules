# Create a VPC
resource "aws_vpc" "matt_vpc" {
  cidr_block       = "174.28.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "eng74_matt_vpc_terraform"
  }
}

# IGW
resource "aws_internet_gateway" "gw" {
  #reference vpc_id dynamically by:
  # calling the resource,
  # followed by the name of the resource
  # followed by the parameter you want
  vpc_id = aws_vpc.matt_vpc.id

  tags = {
    Name = "eng74_matt_igw_terraform"
  }
}
