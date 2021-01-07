# Creating the App EC2 Instance within the VPCs Public Subnet
resource "aws_instance" "app_instance" {
  # AMI was built using Packer previously which utilised Playbooks and Ansible
  ami = var.ami_app
  instance_type = var.instance_type
  associate_public_ip_address = true

  # App should be placed in the Public Subnet to be accessed from the internet
  subnet_id = var.public_subnet_id

  # SG specific to the App
  security_groups = [var.app_sg_id]

  tags = {
  Name = "eng74_matt_app_terraform"
  }
  key_name = var.aws_key

  # Commands which are ran inside the instance
  # Specify the DB_Private IP to connect and start the application
  # Now the App can be seen by simply pasting the Public IP into the browser
  user_data = <<-EOF
        #! /bin/bash
        cd /home/ubuntu/app
        DB_HOST=${var.db_host_ip} pm2 start app.js
        npm run seed
        EOF
}