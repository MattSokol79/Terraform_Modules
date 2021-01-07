# Creating the App EC2 Instance Security Group
resource "aws_security_group" "app_sg" {
  name        = "public_sg_for_app_matt"
  description = "allows traffic to app"
  # Associating with our created VPC
  vpc_id      = var.vpc_id

  ingress {
    description = "HTTPS from anywhere"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # SSH in only from my IP for security
  ingress {
    description = "port 22 from my ip"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.my_ip}/32"]
  }

  # Access to port 80 from anywhere to view app
  ingress {
    description = "HTTP from anywhere"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Port 3000 only from my ip to see functionality
  ingress {
    description = "Port 3000 for my ip"
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["${var.my_ip}/32"]
  }

  # SG default to all traffic out
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "eng74_matt_app_sg_terraform"
  }
}

# Creating the DB EC2 Instance Security Group
resource "aws_security_group" "db_sg" {
    name        = "public_sg_for_db_matt"
    description = "allows traffic to db from app"
    # Associating the SG with our created vpc
    vpc_id      = var.vpc_id

    # Only allows 27017 in from the public subnet to access the DB
    ingress {
        from_port       = 27017
        to_port         = 27017
        protocol        = "tcp"
        security_groups = [aws_security_group.app_sg.id] #How to get an output from a module
    }
    # SG default to all traffic out
    egress {
        from_port       = 0
        to_port         = 0
        protocol        = "-1"
        cidr_blocks     = ["0.0.0.0/0"]
    }
    tags = {
        Name = "eng74_matt_db_sg_terraform"
    }
}
