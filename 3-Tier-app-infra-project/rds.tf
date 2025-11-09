resource "aws_db_subnet_group" "name" {
        name = "db_subnet_group"
        subnet_ids = [ aws_subnet.pvt-7.id , aws_subnet.pvt-8.id ]
        depends_on = [ aws_subnet.pvt-7 , aws_subnet.pvt-8 ]
        tags = {
          Name = "db_subnet_group"
        }
}

resource "aws_db_instance" "rds" {
        instance_class = "db.t3.micro"
        allocated_storage = 20
        identifier = "book-rds"
        db_subnet_group_name = aws_db_subnet_group.name.id
        engine = "mysql"
        engine_version = "8.0"
        multi_az = true
        db_name = "mydb"
        username = var.rds-username
        password = var.rds-password
        skip_final_snapshot = true
        vpc_security_group_ids = [aws_security_group.book-rds-sg.id]
        depends_on = [ aws_db_subnet_group.name ]
        publicly_accessible = false
        

        tags = {
          DB_identifier = "book-rds"
        }
}