data "aws_subnet" "name1" {
        filter {
            name = "tag:Name"
            values = ["subnet-1"]
        }
}


resource "aws_instance" "name" {
    ami = "ami-01760eea5c574eb86"
    instance_type = "t3.micro"
    subnet_id = data.aws_subnet.name1.id
    tags = {
      Name = "Ec2"
    }
  
}