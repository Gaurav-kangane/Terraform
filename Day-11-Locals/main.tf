locals {
        ami = "ami-0305d3d91b9f22e84"
        region = "ap-south-1"
        instance_type = "t3.micro"
}

resource "aws_instance" "name" {
        ami = local.ami
        instance_type = local.instance_type
        tags = {
          Name = "App-${local.region}"
        }
}

