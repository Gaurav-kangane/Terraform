resource "aws_instance" "name" {
    ami = var.ami
    instance_type = var.instance_type
    subnet_id = aws_subnet.name.id
    tags = {
      Name = "dev_ec2"
    }
}

resource "aws_vpc" "name" {
    cidr_block = "10.0.0.0/16"
    tags = {
      Name = "dev"
    }
  
}

resource "aws_subnet" "name" {
    availability_zone = var.availability_zone
    vpc_id = aws_vpc.name.id
    cidr_block = "10.0.0.0/24"
    tags = {
      Name = "dev_sub"
    }

}