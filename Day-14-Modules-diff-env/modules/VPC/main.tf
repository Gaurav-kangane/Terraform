resource "aws_vpc" "vpc" {
        cidr_block = var.cidr_block
        region = var.region
        tags = {
          Name = "${var.env}-vpc"
        }
}

resource "aws_internet_gateway" "ig" {
    vpc_id = aws_vpc.vpc.id
    tags = {
      Name = "${var.env}-ig"
    }
  
}

resource "aws_subnet" "subnet1" {
        cidr_block = var.subnet1_cidr
        vpc_id = aws_vpc.vpc.id
        tags = {
          Name = "${var.env}-subnet"
        }
        availability_zone = var.az1
}

resource "aws_subnet" "subnet2" {
        cidr_block = var.subnet2_cidr
        vpc_id = aws_vpc.vpc.id
        tags = {
          Name = "${var.env}-subnet"
        }
        availability_zone = var.az2
}

output "subnet1_id" {
  value = aws_subnet.subnet1.id

}

output "subnet2_id" {
  value = aws_subnet.subnet2.id
}

output "vpc_id" {
  value = aws_vpc.vpc.id
}