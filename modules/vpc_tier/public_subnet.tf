# Creating the Public Subnet with VPC octets 
resource "aws_subnet" "public_subnet" {
  vpc_id     = aws_vpc.matt_vpc.id
  cidr_block = "174.28.1.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name = "eng74_matt_subnet_public_terraform"
  }
}

# Creating the Public Network ACL 
resource "aws_network_acl" "public_nacl" {
  vpc_id      = aws_vpc.matt_vpc.id
  subnet_ids = [aws_subnet.public_subnet.id]

  # OUT
  # port 80
  # port 443
  # Ephemeral ports 1024-65575
  # Allows out to port 80 accessed from anywhere
  egress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 80
    to_port    = 80
  }

  # Allows out to port 443 accessed from anywhere
  egress {
    protocol   = "tcp"
    rule_no    = 110
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 443
    to_port    = 443
  }

  # Allows out to port 22 accessed only from my ip -> Security
  egress {
    protocol   = "tcp"
    rule_no    = 120
    action     = "allow"
    cidr_block = "${var.my_ip}/32"
    from_port  = 22
    to_port    = 22
  }

  # Allows out to ephemeral ports to anywhere to access app
  egress {
    protocol   = "tcp"
    rule_no    = 130
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 1024
    to_port    = 65535
  }

  # Allows out to port 27017 specifically to the private Subnet to be
  # accessed by the db instance
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
  # Allows in to port 443 from anywhere
  ingress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 443
    to_port    = 443
  }

  # Allows in to port 80 from anywhere so everyone can see the app working
  ingress {
    protocol   = "tcp"
    rule_no    = 110
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 80
    to_port    = 80
  }

  # Allows ssh only from my ip for security reasons
  ingress {
    protocol   = "tcp"
    rule_no    = 120
    action     = "allow"
    cidr_block = "${var.my_ip}/32"
    from_port  = 22
    to_port    = 22
  }

  # Allows in to ephemeral ports from anywhere for updates and access
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


# Creating the Route Table for the Public Subnet
resource "aws_route_table" "route_public_table"{
  vpc_id = aws_vpc.matt_vpc.id

  # As the subnet is public, it has access to the internet via the IGW
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "eng74_matt_app_route_table_terraform"
  }

}

# Associates the route table to the subnet
resource "aws_route_table_association" "route_public_association"{
  route_table_id = aws_route_table.route_public_table.id
  subnet_id = aws_subnet.public_subnet.id
}