# Variables used within the code needed to be specified but are provided
# From other sources e.g. outputs

variable "ami_app" {
    description = "Id of the App AMI"
}

variable "public_subnet_id" {
    description = "Public Subnet ID"
}

variable "instance_type" {
    description = "Type of EC2 Instance in this case t2.micro"
}

variable "app_sg_id" {
    description = "App Security Group ID"
}

variable "db_host_ip" {
    description = "Private IP of DB EC2 Instance"
}

variable "aws_key" {
    description = "AWS stored Key used for SSH"
}