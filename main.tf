# Module Used to obtain my IP address without specifying in file
module myip {
  source  = "4ops/myip/http"
  version = "1.0.0"
}

# Region for the AWS 
provider "aws" {
 region = var.region
#access_key = "must not write the key here"
#secert_key = "must not write the key here"
}

# VPC Module Sets up the VPC including the Public and Private Subnets
# Along with the Route Tables as well as the Internet Gateway
module "vpc" {
    source = "./modules/vpc_tier"

    my_ip = module.myip.address
}

# SG Module sets up the security groups for the EC2 Instances
module "sg" {
    source = "./modules/sg_tier"

    vpc_id = module.vpc.vpc_id
    my_ip = module.myip.address
}

# App Module Sets up the App EC2 Instance 
module "app" {
  source = "./modules/app_tier"

  public_subnet_id = module.vpc.public_subnet_id
  ami_app = var.ami_app
  instance_type = var.instance_type
  db_host_ip = module.db.db_host_ip
  aws_key = var.aws_key
  app_sg_id = module.sg.app_sg_id

  # User_Data depends on the DB being created first due to commands within
  depends_on = [
    module.db.aws_instance
  ]
}

# DB Module Sets up the DB EC2 Instance
module "db" {
  source = "./modules/db_tier"

  private_subnet_id = module.vpc.private_subnet_id
  ami_db = var.ami_db
  instance_type = var.instance_type
  aws_key = var.aws_key
  db_sg_id = module.sg.db_sg_id
  
}

module "load_balancers" {
  source = "./modules/load_balancer"

  vpc_id = module.vpc.vpc_id
  public_subnet_id = module.vpc.public_subnet_id
  ami_app = var.ami_app
  aws_key = var.aws_key
  app_sg_id = module.sg.app_sg_id
  db_host_ip = module.db.db_host_ip
}





# Monitor
# Decide trigger
# ask it to scale out
# replicate ec2 withing public subnet
# Load balancer to distribute traffic to new ec2
# We will use built in tools from AWS