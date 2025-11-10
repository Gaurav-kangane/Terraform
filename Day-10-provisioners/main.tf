resource "aws_vpc" "name" {
        cidr_block = "10.0.0.0/16"
        tags = {
          Name = "vpc"
        }
}   

resource "aws_subnet" "name" {
        vpc_id = aws_vpc.name.id
        cidr_block = "10.0.1.0/24"
        availability_zone = "ap-south-1a"
        map_public_ip_on_launch = true
        tags = {
          Name = "Public-subnet"
        }
}

#internet gateway 
resource "aws_internet_gateway" "name" {
        vpc_id = aws_vpc.name.id

}

#route table
resource "aws_route_table" "name" {
        vpc_id = aws_vpc.name.id

        route {
            cidr_block = "0.0.0.0/0"
            gateway_id = aws_internet_gateway.name.id
        }
}

#Associate Route Table
resource "aws_route_table_association" "name" {
        route_table_id = aws_route_table.name.id
        subnet_id = aws_subnet.name.id
  
}

# Security group
resource "aws_security_group" "name" {
        vpc_id = aws_vpc.name.id
        name = "gsk-sg"


        ingress {
            description = "allow-http"
            from_port = 80
            to_port = 80
            protocol = "tcp"
            cidr_blocks = [ "0.0.0.0/0" ]
        }

        ingress {
            description = "allow-ssh"
            from_port = 22
            to_port = 22
            protocol = "tcp"
            cidr_blocks = [ "0.0.0.0/0" ]
        }

        egress {
            from_port = 0
            to_port = 0
            protocol = "-1"
            cidr_blocks = [ "0.0.0.0/0" ]
        }
}

#key pair
# resource "aws_key_pair" "name" {
#         key_name = "task"
#         public_key = file("~/Users/Dell/.ssh/id_ed25519")
# }

#Ec2 instance Ubuntu
resource "aws_instance" "server" {
        ami = "ami-02b8269d5e85954ef"
        instance_type = "t3.micro"
        key_name = "custkey"
        subnet_id = aws_subnet.name.id
        vpc_security_group_ids = [ aws_security_group.name.id ]
        associate_public_ip_address = true


        tags = {
          Name = "Ubuntu-server"
        }


        # connection {
        #   type = "ssh"
        #   user = "ubuntu"
        #   private_key = file("custkey.pem")  # path to private key
        #   host = self.public_ip
        #   timeout = "2m"
        # }


        # #This Terraform provisioner "file" block is used to copy a local file from your machine to a remote server (such as an EC2 instance) after the instance is created.
        # provisioner "file" {
        #         source = "file10"
        #         destination = "/home/ubuntu/file10"
        # }


        # provisioner "remote-exec" {
        #     inline = [                    #This argument lets you specify a list of commands to run sequentially on the remote host.
        #         "touch /home/ubuntu/file200",
        #         "echo 'hello from aws' >>  /home/ubuntu/file200" 
        #      ]  
        # }   
       

        # #This Terraform provisioner "local-exec" block is used to run a command on your local machine (where Terraform is running) — not on the remote server.
        # provisioner "local-exec" {
        #   command = "touch file500"
        # }
}


resource "null_resource" "run_script" {
  provisioner "remote-exec" {
    connection {
      host        = aws_instance.server.public_ip
      user        = "ubuntu"
      private_key = file("custkey")
    }

    inline = [
      "echo 'hello from awsdevopsmulticloud' >> /home/ubuntu/file200"
    ]
  }

  triggers = {
    always_run = "${timestamp()}" # Forces rerun every time
  }
}

