# User data in AWS EC2 is a script or set of commands that automatically runs the first time an instance launches. 
# It’s often used to install software, configure the system, or run setup tasks during boot.



resource "aws_instance" "name" {
  ami           = "ami-01760eea5c574eb86"
  instance_type = "t3.micro"
  user_data     = file("test.sh")

  tags = {
    Name = "dev"
  }
}
