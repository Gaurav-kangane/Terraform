resource "aws_instance" "bation" {
        ami = var.ami
        instance_type = var.ami
        key_name = var.key_name
        subnet_id = aws_subnet.pvt-3.id
        associate_public_ip_address = true
        vpc_security_group_ids = [ aws_security_group.bation-sg.id ]
        tags = {
          Name = "bation"
        }
  
} 

resource "aws_instance" "frontend" {
        ami = var.ami
        instance_type = var.instance_type
        key_name = var.key_name
        subnet_id = aws_subnet.pvt-3.id
        vpc_security_group_ids = [ aws_security_group.frontend-server-sg.id ]
        associate_public_ip_address = false
        tags = {
          Name = "frontend"
        }
  
}


resource "aws_instance" "backend" {
        ami = "ami-0305d3d91b9f22e84"
        instance_type = var.instance_type
        key_name = var.key_name
        subnet_id = aws_subnet.pvt-6.id
        vpc_security_group_ids = [ aws_security_group.backend-server-sg.id ]
        associate_public_ip_address = false 
        tags = {
          Name = "backend"
        }
  
}