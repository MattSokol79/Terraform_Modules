#Instance EC2
resource "aws_instance" "db_instance" {
  ami = var.ami_db
  instance_type = var.instance_type
  associate_public_ip_address = true

  # placing instance in correct subnet
  subnet_id = var.private_subnet_id

  # Attaching correct SG
  security_groups = [var.db_sg_id]
  key_name = var.aws_key

  tags = {
  Name = "eng74_matt_db_terraform"
  }
}
