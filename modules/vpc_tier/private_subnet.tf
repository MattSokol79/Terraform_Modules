# Creating the PRIVATE Subnet
resource "aws_subnet" "private_subnet" {
  vpc_id     = aws_vpc.matt_vpc.id
  cidr_block = "174.28.2.0/24"
  # map_private_ip_on_launch = true

  tags = {
    Name = "eng74_matt_subnet_private_terraform"
  }
}


# Creating the PRIVATE Network ACL 
resource "aws_network_acl" "private_nacl" {
  vpc_id      = aws_vpc.matt_vpc.id
  subnet_ids = [aws_subnet.private_subnet.id]

  # OUT
  # port 80
  # port 443
  # Ephemeral ports 1024-65575
  egress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 1024
    to_port    = 65535
  }

  # IN
  # Port 22
  # Port 80
  # Port 443
  # Ephemeral ports 1024-65575
  ingress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "174.28.2.0/24"
    from_port  = 22
    to_port    = 22
  }
  
  ingress {
    protocol   = "tcp"
    rule_no    = 110
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 27017
    to_port    = 27017
  }

  tags = {
    Name = "eng74_matt_NACL_db_terraform"
  }
}

# Creating the Route Table for the Private Subnet
resource "aws_route_table" "route_private_table"{
  vpc_id = aws_vpc.matt_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "eng74_matt_route_table_db_terraform"
  }

}

# Associating the Private Route Table to the Private Subnet
resource "aws_route_table_association" "route_private_association"{
  route_table_id = aws_route_table.route_private_table.id
  subnet_id = aws_subnet.private_subnet.id
}
