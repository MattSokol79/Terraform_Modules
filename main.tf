module myip {
  source  = "4ops/myip/http"
  version = "1.0.0"
}

provider "aws" {
 region = var.region
#access_key = "must not write the key here"
#secert_key = "must not write the key here"
}

# Call the vpc modules
module "vpc" {
    source = "./modules/vpc_tier"

    my_ip = module.myip.address
}

# Call the security groups module
module "sg" {
    source = "./modules/sg_tier"

    vpc_id = module.vpc.vpc_id
    my_ip = module.myip.address
}

# call the app module
module "app" {
  source = "./modules/app_tier"

  public_subnet_id = module.vpc.public_subnet_id
  ami_app = var.ami_app
  instance_type = var.instance_type
  db_host_ip = module.db.db_host_ip
  aws_key = var.aws_key
  app_sg_id = module.sg.app_sg_id
  depends_on = [
    module.db.aws_instance
  ]
}

# call the db module
module "db" {
  source = "./modules/db_tier"

  private_subnet_id = module.vpc.private_subnet_id
  ami_db = var.ami_db
  instance_type = var.instance_type
  aws_key = var.aws_key
  db_sg_id = module.sg.db_sg_id
  
}






# Monitor
# Decide trigger
# ask it to scale out
# replicate ec2 withing public subnet
# Load balancer to distribute traffic to new ec2
# We will use built in tools from AWS