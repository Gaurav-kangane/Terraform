provider "aws" {
   region = var.region
   #profile = "prod"
}

module "vpc" {
    source = "../../modules/VPC"
    cidr_block = var.cidr_block
    subnet1_cidr = var.subnet1_cidr
    subnet2_cidr = var.subnet2_cidr
    region = var.region
    env = var.env
    az1 = var.az1
    az2 = var.az2
}

module "ec2" {
   source = "../../modules/EC2"
   subnet_id = module.vpc.subnet1_id
   ami = var.ami
   instance_type = var.instance_type
   env = var.env
}


module "rds" {
   source = "../../modules/RDS"
   engine = var.engine
   db_identifier = var.identifier
   username = var.username
   password = var.password
   allocated_storage = var.allocated_storage
   instance_class = var.instance_class
   db_subnet_group_name = var.db_subnet_group_name
   subnet1_id = module.vpc.subnet1_id
   subnet2_id = module.vpc.subnet2_id
   env = var.env
}


module "s3_bucket" {
   source = "../../modules/S3"
   bucket_name = var.bucket_name
   region = var.region
}