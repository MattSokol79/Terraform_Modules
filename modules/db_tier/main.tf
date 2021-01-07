# Creating the DB EC2 Instance within the VPCs Private Subnet
resource "aws_instance" "db_instance" {
  # AMI was built using Packer previously which utilised Playbooks and Ansible
  ami = var.ami_db
  instance_type = var.instance_type
  associate_public_ip_address = true

  # Instance placed within the Private Subnet where DB needs to be
  subnet_id = var.private_subnet_id

  # SG relevant to the DB
  security_groups = [var.db_sg_id]
  # Key used to ssh if needed
  key_name = var.aws_key

  tags = {
  Name = "eng74_matt_db_terraform"
  }
}
