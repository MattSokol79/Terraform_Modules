# APP module
# move the app into the subnet ad try to get tge 502 error on port 80
#Instance EC2
resource "aws_instance" "app_instance" {
  ami = var.ami_app
  instance_type = var.instance_type
  associate_public_ip_address = true

  # placing instance in correct subnet
  subnet_id = var.public_subnet_id

  # Attaching correct SG
  security_groups = [var.app_sg_id]

  tags = {
  Name = "eng74_matt_app_terraform"
  }
  key_name = var.aws_key
  user_data = <<-EOF
        #! /bin/bash
        cd /home/ubuntu/app
        DB_HOST=${var.db_host_ip} pm2 start app.js
        npm run seed
        EOF
}