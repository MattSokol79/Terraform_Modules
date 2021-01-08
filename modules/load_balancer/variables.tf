variable "vpc_id" {
    description = "The terraform VPC ID"
}

variable "public_subnet_id" {
    description = "Public subnet id"
}

variable "ami_app" {
    description = "AMI ID used in launch config"
}

variable "aws_key" {
    description = "AWS SSH key" 
}

variable "app_sg_id" {
    description = "App SG attached to new instances"
}

variable "db_host_ip" {
    description = "Private IP of DB"
}
