# Below Variables are important in running the code
# Supply the AMI Ids, region of the AWS, aws_key name as well as Instance Type
variable "region" {
    description = "AWS Region to deploy in"
    default = "eu-west-1"
}

variable "ami_app" {
    description = "ID of App AMI to deploy from"
    default = "ami-0d645d116113782c5"
}

variable "ami_db" {
    description = "ID of DB AMI to deploy from"
    default = "ami-026f0bb06657f628a"
}

variable "aws_key" {
    description = "Key stored on AWS to SSH in with"
    default = "eng74.matt.aws.key"
}

variable "instance_type" {
    description = "Type of EC2 Instance, in this case t2.micro"
    default = "t2.micro"
}

