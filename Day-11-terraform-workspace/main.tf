provider "aws" {
  
}

resource "aws_s3_bucket" "name" {
        bucket = "kangane"
        region = "ap-south-1"
}   

resource "aws_vpc" "name" {
        cidr_block = "10.0.0.0/16"
        tags = {
          Name = "default"
        }
}


#In Terraform, a workspace is a way to manage multiple environments (like dev, staging, and prod) 
#using the same Terraform configuration — without keeping separate directories or files.
/*

terraform workspace = to show all commands
terraform workspace new dev == dev workspace will be created
Subcommands:
    delete    Delete a workspace
    list      List Workspaces
    new       Create a new workspace
    select    Select a workspace
    show      Show the name of the current workspace  */