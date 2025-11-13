provider "aws" {
  
}

resource "aws_security_group" "name" {
        name = "project-sg"
        description = "Allow inbound traffic"


        ingress = [
            for port in [22,80,443,8080,3000,3306]:{
                description = "Inbound traffic"
                from_port = port
                to_port = port
                protocol = "tcp"
                cidr_blocks = ["0.0.0.0/0"]
                ipv6_cidr_blocks = []
                prefix_list_ids  = []
                security_groups  = []
                self = false
            }
        ]

        egress {
            from_port   = 0
            to_port     = 0
            protocol    = "-1"
            cidr_blocks = ["0.0.0.0/0"]
        }

        tags = {
          Name = "project-sg"
        }
}

