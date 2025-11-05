resource "aws_db_instance" "name"{
        instance_class ="db.t3.micro"
        identifier = "my-db-instance"
        engine = "mysql"
        engine_version = "8.0.43"
        username = "admin"
        password = "Cloud123"    #self managed 
        allocated_storage = 10
        db_subnet_group_name = aws_db_subnet_group.subnet_group.id
        

        #Enable backups and retention
        backup_retention_period = 7
        backup_window = "02:00-03:00"

        #Monitoring (CloudWatch Enhanced Monitoring)
        monitoring_interval = 60
        monitoring_role_arn = aws_iam_role.rds_monitoring_role.arn
        
        #Enable performance insight (not for free tier account)
        # performance_insights_enabled          = true
        # performance_insights_retention_period = 7  # Retain insights for 7 days
        
        #maintenance window
        maintenance_window = "sun:03:00-sun:04:00" #maintenance every sunday (UTC)

       skip_final_snapshot = true



        depends_on = [ aws_db_subnet_group.subnet_group ]

}




# IAM Role for RDS Enhanced Monitoring
resource "aws_iam_role" "rds_monitoring_role" {
  name = "rds-monitoring-role-gsk"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "monitoring.rds.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "rds_monitoring_policy" {
            role = aws_iam_role.rds_monitoring_role.name
            policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole"
  
}

resource "aws_vpc" "name" {
        cidr_block = "10.0.0.0/16"
        tags = {
          Name = "gsk-vpc"
        }
}

resource "aws_subnet" "subnet1" {
        vpc_id = aws_vpc.name.id
        availability_zone = "ap-south-1a"
        cidr_block = "10.0.1.0/24"
        tags = {
          Name = "subnet-1"
        }
}

resource "aws_subnet" "subnet2" {
        vpc_id = aws_vpc.name.id
        availability_zone = "ap-south-1b"
        cidr_block = "10.0.2.0/24"
        tags = {
          Name = "subnet-2"
        }
}

resource "aws_db_subnet_group" "subnet_group" {
        name = "gsk_subnet_group"
        subnet_ids = [aws_subnet.subnet1.id, aws_subnet.subnet2.id]

  
}