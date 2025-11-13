provider "aws" {
  
}

variable "env" {
  type = list(string)
  default = ["dev","test", "prod" ]
}

resource "aws_instance" "name" {
  ami = "ami-0305d3d91b9f22e84"
  instance_type = "t3.micro"
  for_each = toset(var.env)
  tags = {
    Name = each.value
  }
}