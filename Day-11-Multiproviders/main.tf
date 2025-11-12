resource "aws_vpc" "name" {
    cidr_block = "10.0.0.0/16"
    tags = {
        Name = "Mumbai"
    }
}


# this resource create in us-east-1
