# Below variables are used throughout the code, but are provided 
# From other sources

variable "ami_db" {
    description = "AMI id of the DB"
}

variable "private_subnet_id" {
    description = "Private Subnet ID"
}

variable "instance_type" {
    description = "Instance type of EC2 Instance in this case t2.micro"
}

variable "db_sg_id" {
    description = "Security group for the DB EC2 Instance"
}

variable "aws_key" {
    description = "SSH Key stored on AWS used to SSH into the machines"
}