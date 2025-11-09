resource "aws_vpc" "name" {
        cidr_block = "10.0.0.0/16"
        enable_dns_hostnames = true
        tags = {
          Name = "Gsk-Project"
        }
}

# For frontend load balancer
resource "aws_subnet" "pub-1" {
            vpc_id = aws_vpc.name.id
            cidr_block = "10.0.1.0/24"
            tags = {
              Name = "pub-subnet-1a"
            }
            availability_zone = "ap-south-1a"
            map_public_ip_on_launch = true # for auto assign public ip for subnet
  
}

# For frontend load balancer
resource "aws_subnet" "pub-2" {
            vpc_id = aws_vpc.name.id
            cidr_block = "10.0.2.0/24"
            tags = {
              Name = "pub-subnet-1b"
            }
            availability_zone = "ap-south-1b"
            map_public_ip_on_launch = true # for auto assign public ip for subnet
  
}

# frontend server
resource "aws_subnet" "pvt-3" {
            vpc_id = aws_vpc.name.id
            cidr_block = "10.0.3.0/24"
            tags = {
              Name = "frontend-1a"
            }
            availability_zone = "ap-south-1a"
            
}

# frontend server
resource "aws_subnet" "pvt-4" {
            vpc_id = aws_vpc.name.id
            cidr_block = "10.0.4.0/24"
            tags = {
              Name = "frontend-1b"
            }
            availability_zone = "ap-south-1b"
            
}

# backend server
resource "aws_subnet" "pvt-5" {
            vpc_id = aws_vpc.name.id
            cidr_block = "10.0.5.0/24"
            tags = {
              Name = "backend-1a"
            }
            availability_zone = "ap-south-1a"
            
}

# backend server
resource "aws_subnet" "pvt-6" {
            vpc_id = aws_vpc.name.id
            cidr_block = "10.0.6.0/24"
            tags = {
              Name = "backend-1b"
            }
            availability_zone = "ap-south-1b"
            
}

# rds server
resource "aws_subnet" "pvt-7" {
            vpc_id = aws_vpc.name.id
            cidr_block = "10.0.7.0/24"
            tags = {
              Name = "rds-1a"
            }
            availability_zone = "ap-south-1a"
            
}

#rds server
resource "aws_subnet" "pvt-8" {
            vpc_id = aws_vpc.name.id
            cidr_block = "10.0.8.0/24"
            tags = {
              Name = "rds-1b"
            }
            availability_zone = "ap-south-1b"
            
}


# internet gateway
resource "aws_internet_gateway" "name" {
        vpc_id = aws_vpc.name.id
        tags = {
          Name = "Gsk-ig"
        }
}


# creating public route table
resource "aws_route_table" "public_rt" {
        vpc_id = aws_vpc.name.id
        tags = {
          Name = "pub-rt"
        }

        route {
            cidr_block = "0.0.0.0/0"
            gateway_id = aws_internet_gateway.name.id
        }
}

# attaching pub-1 subnet to public route table
resource "aws_route_table_association" "pub-1" {
        route_table_id = aws_route_table.public_rt.id
        subnet_id = aws_subnet.pub-1.id
}

# attaching pub-2 subnet to public route table
resource "aws_route_table_association" "pub-2" {
        route_table_id = aws_route_table.public_rt.id
        subnet_id = aws_subnet.pub-2.id
}

# creating elastic ip for nat gateway
resource "aws_eip" "eip" {
  
}

# creating nat gateway
resource "aws_nat_gateway" "nat" {
        subnet_id = aws_subnet.pub-1.id
        connectivity_type = "public"
        allocation_id = aws_eip.eip.id
        tags = {
          Name = "Gsk-nat"
        }
}

# creating private route table
resource "aws_route_table" "pvt-rt" {
        vpc_id = aws_vpc.name.id
        tags = {
          Name = "pvt-rt"
        }
        route {
            cidr_block = "0.0.0.0/0"
            gateway_id = aws_nat_gateway.nat.id
        }
  
}

# attaching private route table to pvt-3
resource "aws_route_table_association" "pvt-3" {
        route_table_id = aws_route_table.pvt-rt.id
        subnet_id = aws_subnet.pvt-3.id
}

# attaching private route table to pvt-4
resource "aws_route_table_association" "pvt-4" {
        route_table_id = aws_route_table.pvt-rt.id
        subnet_id = aws_subnet.pvt-4.id
}

# attaching private route table to pvt-5
resource "aws_route_table_association" "pvt-5" {
        route_table_id = aws_route_table.pvt-rt.id
        subnet_id = aws_subnet.pvt-5.id
}

# attaching private route table to pvt-6
resource "aws_route_table_association" "pvt-6" {
        route_table_id = aws_route_table.pvt-rt.id
        subnet_id = aws_subnet.pvt-6.id
}

# attaching private route table to pvt-7
resource "aws_route_table_association" "pvt-7" {
        route_table_id = aws_route_table.pvt-rt.id
        subnet_id = aws_subnet.pvt-7.id
}

# attaching private route table to pvt-8
resource "aws_route_table_association" "pvt-8" {
        route_table_id = aws_route_table.pvt-rt.id
        subnet_id = aws_subnet.pvt-8.id
}
