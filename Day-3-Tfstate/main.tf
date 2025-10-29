resource "aws_instance" "name" {
  ami = var.ami
  instance_type = var.instance_type
  tags = {
    Name = "gsk-ec2"
  }
}

resource "aws_vpc" "name" {
    cidr_block = "10.0.0.0/16"
    tags = {
      Name = "gsk-vpc"
    }
}

resource "aws_subnet" "name" {
    vpc_id = aws_vpc.name.id
    cidr_block = "10.0.0.0/24"
    tags = {
      Name = "gsk-subnet"
    }
    availability_zone = var.availability_zone
}

resource "aws_s3_bucket" "name" {
    bucket = "kangane"
    
}