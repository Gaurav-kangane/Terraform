resource "aws_vpc" "name" {
        cidr_block = "10.0.0.0/16"
        tags = {
          Name = "Prod-vpc"
        }
}

resource "aws_subnet" "subnet1" {
        vpc_id = aws_vpc.name.id
        cidr_block = "10.0.1.0/24"
        tags = {
          Name = "subnet-1"
        }
        availability_zone = "ap-south-1a"
  
}

resource "aws_subnet" "subnet2" {
        vpc_id = aws_vpc.name.id
        cidr_block = "10.0.2.0/24"
        tags = {
          Name = "subnet-2"
        }
        availability_zone = "ap-south-1b"
  
}

resource "db_subnet_group_name" "subnet_grp" {
        name = "mydb_subnet_group"
        subnet_ids = [aws_subnet.subnet1.id , aws_subnet.subnet2.id]
        tags ={
            Name = "mydb_subnet_group"
        }
        depends_on = [ aws_subnet.subnet1, aws_subnet.subnet2 ]
}

resource "aws_db_instance" "name" {
        engine = "mysql"
        identifier = "Prod_db"
        engine_version = "8.0.43"
        instance_class = "db.t3.micro"
        username = "admin"
        password = "Cloud123"
        allocated_storage = 10
        db_subnet_group_name = aws_db_subnet_group.subnet_grp.id 
        publicly_accessible = false

        monitoring_interval = 7
        monitoring_role_arn = aws_iam_role.rds_enhanced_monitoring_role.arn

        depends_on = [ db_subnet_group_name.subnet_grp ]
}


resource "aws_iam_role" "rds_enhanced_monitoring_role" {
       name = "rds-enhanced-monitoring-role"

    assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "monitoring.rds.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "rds_enhanced_monitoring_policy" {
    role = aws_iam_role.rds_enhanced_monitoring_role.name
    policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole"
    depends_on = [ aws_iam_role.rds_enhanced_monitoring_role]
}

resource "aws_db_instance" "read_replica" {
        identifier = "My-read-replica"
        instance_class = "db.t3.micro"
        replicate_source_db = aws_db_instance.name.id
        db_subnet_group_name = aws_db_subnet_group.subnet_grp.id
        publicly_accessible = false
        skip_final_snapshot = true
        monitoring_interval = 60
        monitoring_role_arn = aws_iam_role.rds_enhanced_monitoring_role.arn
        depends_on = [ aws_db_instance.name ]
        tags = {
            Name = "My-read-replica"
        }
}