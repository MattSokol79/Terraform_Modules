# Create a public subnet
resource "aws_subnet" "public_subnet" {
  vpc_id     = aws_vpc.matt_vpc.id
  cidr_block = "174.28.1.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name = "eng74_matt_subnet_public_terraform"
  }
}

# NCLS. --- Task 1
resource "aws_network_acl" "public_nacl" {
  vpc_id      = aws_vpc.matt_vpc.id
  subnet_ids = [aws_subnet.public_subnet.id]

  # OUT
  # port 80
  # port 443
  # Ephemeral ports 1024-65575
  egress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 80
    to_port    = 80
  }

  egress {
    protocol   = "tcp"
    rule_no    = 110
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 443
    to_port    = 443
  }

  egress {
    protocol   = "tcp"
    rule_no    = 120
    action     = "allow"
    cidr_block = "${var.my_ip}/32"
    from_port  = 22
    to_port    = 22
  }

  egress {
    protocol   = "tcp"
    rule_no    = 130
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 1024
    to_port    = 65535
  }

  egress {
    protocol   = "tcp"
    rule_no    = 140
    action     = "allow"
    cidr_block = "174.28.2.0/24"
    from_port  = 27017
    to_port    = 27017
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
    cidr_block = "0.0.0.0/0"
    from_port  = 443
    to_port    = 443
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 110
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 80
    to_port    = 80
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 120
    action     = "allow"
    cidr_block = "${var.my_ip}/32"
    from_port  = 22
    to_port    = 22
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 130
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 1024
    to_port    = 65535
  }

  tags = {
    Name = "eng74_matt_NACL_app_terraform"
  }
}


# ROUTES
resource "aws_route_table" "route_public_table"{
  vpc_id = aws_vpc.matt_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "eng74_matt_app_route_table_terraform"
  }

}

resource "aws_route_table_association" "route_public_association"{
  route_table_id = aws_route_table.route_public_table.id
  subnet_id = aws_subnet.public_subnet.id
}