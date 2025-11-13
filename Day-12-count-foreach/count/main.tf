provider "aws" {
  
}


# count is a meta argument in Terraform that lets you create multiple copies of a resource with a simple number. 
# It is one of the easiest ways to scale resources without writing the same block again and again.


## Example 1
resource "aws_instance" "name" {
    ami = "ami-0305d3d91b9f22e84"
    instance_type = "t3.micro"
    count = 2

    tags = {
      Name = "dev"
    }
  
}



## Example 2

variable "env" {
    type = list(string)
    default = [ "server-1","server-2","server-3" ]
  
}

resource "aws_instance" "name" {
        ami = "ami-0305d3d91b9f22e84"
        instance_type = "t3.micro"
        count = length(var.env)
        tags = {
          Name = var.env[count.index]
        }
}