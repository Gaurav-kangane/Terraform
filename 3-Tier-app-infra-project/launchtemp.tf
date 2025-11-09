data "aws_instances" "frontend" {
  filter {
    name   = "tag:Name"
    values = ["frontend"]  
  }
}

# Step 2: Get details of the first matching instance
data "aws_instance" "frontend" {
  instance_id = data.aws_instances.frontend.ids[0]
}


# Launch Template Resource
resource "aws_launch_template" "frontend" {
  name = "frontend-terraform"
  description = "frontend-terraform"
  image_id = data.aws_instance.frontend.ami
  instance_type = "t3.micro"
  vpc_security_group_ids = [aws_security_group.frontend-server-sg.id]
  key_name = "custkey" #chnage the key 
  #user_data = filebase64("${path.module}/frontend-lt.sh")
  #default_version = 1
  update_default_version = true
  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "frontend-terraform"
    }
  }
}







data "aws_instances" "backend" {
  filter {
    name   = "tag:Name"
    values = ["backend"]   
  }
}

#  Get details of the first matching instance
data "aws_instance" "backend" {
  instance_id = data.aws_instances.backend.ids[0]
}


# Launch Template Resource
resource "aws_launch_template" "backend" {
  name = "backend-terraform"
  description = "backend-terraform"
  image_id = data.aws_instance.backend.ami
  instance_type = "t3.micro"
  vpc_security_group_ids = [aws_security_group.backend-server-sg.id]
  key_name = "custkey" 
  #user_data = filebase64("${path.module}/backend-lt.sh")
  #default_version = 1
  update_default_version = true
  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "backend-terraform"
    }
  }
}