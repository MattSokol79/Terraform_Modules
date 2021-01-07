# Below Variables are important in running the code
# Supply the AMI Ids, region of the AWS, aws_key name as well as Instance Type
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

