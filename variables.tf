# research how to create variables in terraform to use in main.tf
# use the variable instead of hard coding in main.tf

variable "region" {
default = "eu-west-1"
}

variable "ami_app" {
    default = "ami-0d645d116113782c5"
}

variable "ami_db" {
    default = "ami-026f0bb06657f628a"
}

variable "aws_key" {
default = "eng74.matt.aws.key"
}

variable "instance_type" {
default = "t2.micro"
}

