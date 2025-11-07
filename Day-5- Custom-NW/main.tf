resource "aws_vpc" "name" {
        cidr_block = "10.0.0.0/16"
        tags = {
          Name = "Gsk-vpc"
        }
}

resource "aws_internet_gateway" "name" {
        vpc_id = aws_vpc.name.id
        tags = {
          Name = "Gsk-ig"
        }
}

resource "aws_subnet" "public" {
        vpc_id = aws_vpc.name.id
        cidr_block = "10.0.0.0/24"
        availability_zone = "ap-south-1a"
        tags = {
          Name = "Public-subnet"
        }
}

resource "aws_subnet" "private" {
        cidr_block = "10.0.1.0/24"
        vpc_id = aws_vpc.name.id
        availability_zone = "ap-south-1a"
        tags = {
          Name = "Private-subnet"
        }
}

resource "aws_route_table" "name" {
        vpc_id = aws_vpc.name.id
        route {
            cidr_block = "0.0.0.0/0"
            gateway_id = aws_internet_gateway.name.id
        }
        tags = {
          Name = "pub-rt"
        }
}

resource "aws_route_table_association" "name" {
        subnet_id = aws_subnet.public.id
        route_table_id = aws_route_table.name.id
}

resource "aws_security_group" "name" {
  name        = "allow_tls"
  vpc_id      = aws_vpc.name.id

  tags = {
    Name = "Gsk-sg"
  }

  # Allow HTTP
  ingress {
    description = "Allow HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow SSH
  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "public" {
        ami = "ami-01760eea5c574eb86"
        instance_type = "t3.micro"
        vpc_security_group_ids = [aws_security_group.name.id]
        subnet_id = aws_subnet.public.id
        associate_public_ip_address = true
        tags = {
          Name = "public-ec2"
        }
}

resource "aws_instance" "name" {
        ami = ""
        instance_type = "t3.micro"
        vpc_security_group_ids = [ aws_security_group.name.id ]
        subnet_id = aws_subnet.private.id
        associate_public_ip_address = false
        key_name = "custkey"
        tags = {
          Name = "Private-ec2"
        }
}

resource "aws_eip" "nat_eip" {
        domain = "vpc"
        tags = {
          Name = "Gsk-eip"
        }
}

resource "aws_nat_gateway" "name" {
        subnet_id = aws_subnet.public.id
        connectivity_type = "public"
        allocation_id = aws_eip.nat_eip.id
        tags = {
          Name = "Gsk-nat"
        }
}   

resource "aws_route_table" "pvt-rt" {
        vpc_id = aws_vpc.name.id

        route  {
            cidr_block = "0.0.0.0/0"
            nat_gateway_id = aws_nat_gateway.name.id
            
        }
        tags = {
          Name = "private-rt"
        }
}

resource "aws_route_table_association" "name2" {
        subnet_id = aws_subnet.private.id
        route_table_id = aws_route_table.pvt-rt.id 
}