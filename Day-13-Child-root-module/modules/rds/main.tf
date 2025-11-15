resource "aws_db_subnet_group" "name" {
        name = "db-subnet-group"
        subnet_ids = [var.subnet1_id,var.subnet2_id]

        tags = {
          Name = "My-db-subnet-group"
        }
}


resource "aws_db_instance" "name" {
        allocated_storage = 20
        instance_class = var.instance_class
        engine = "mysql"
        engine_version = "8.0"
        db_name = var.db_name
        username = var.username
        password = var.password
        db_subnet_group_name = aws_db_subnet_group.name.name
        skip_final_snapshot = true
}