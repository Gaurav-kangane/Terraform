resource "aws_db_subnet_group" "name" {
        name = var.db_subnet_group_name
        subnet_ids = [ var.subnet1_id , var.subnet2_id ]
        tags = {
          Name = "${var.env}"
        }
}


resource "aws_db_instance" "db_instance" {
        identifier = var.db_identifier
        instance_class = var.instance_class
        username = var.username
        password = var.password
        engine = var.engine
        allocated_storage = var.allocated_storage
        db_subnet_group_name = aws_db_subnet_group.name.name
        skip_final_snapshot = true
  
}