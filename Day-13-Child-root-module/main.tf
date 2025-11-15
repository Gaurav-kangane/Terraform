provider "aws" {
  
}


module "vpc" {
        source = "./modules/vpc"
        cidr_block = "10.0.0.0/16"
        subnet_1_cidr = "10.0.1.0/24"
        subnet_2_cidr = "10.0.2.0/24"
        az1 = "ap-south-1a"
        az2 = "ap-south-1b"
}


module "ec2" {
        source = "./modules/ec2"
        instance_type = "t3.micro"
        ami = "ami-0305d3d91b9f22e84"
        subnet_1_id = module.vpc.subnet_1_id
}


module "rds" {
        source = "./modules/rds"
        db_name = "mydatabase"
        username = "admin"
        password = "Cloud123"
        instance_class = "db.t3.micro"
        subnet1_id = module.vpc.subnet_1_id
        subnet2_id = module.vpc.subnet_2_id
}