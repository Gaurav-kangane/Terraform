resource "aws_instance" "name" {
        ami = var.ami
        instance_type = var.instance_type
        tags = {
          Name = "prod"
        }
}

resource "aws_s3_bucket" "name" {
        bucket = "kangane"
        region = "ap-south-1"
}
