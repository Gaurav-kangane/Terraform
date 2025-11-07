# creating key pair 
resource "aws_key_pair" "name" {
        key_name = "task"
        public_key = file("C:/Users/DELL/.ssh/id_dataAMI_.pub")

}

resource "aws_instance" "name" {
        ami = "ami-01760eea5c574eb86"
        instance_type = "t3.micro"
        key_name = aws_key_pair.name.key_name
}