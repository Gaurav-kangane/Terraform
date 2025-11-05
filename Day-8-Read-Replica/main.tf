# we are creating the read replica for existing database
# Existing DB instance (source)
data "aws_db_instance" "primary" {
  db_instance_identifier = "book-rds"  # your existing RDS instance
}

# Read Replica
resource "aws_db_instance" "read_replica" {
  identifier              = "my-read-replica"
  replicate_source_db     = data.aws_db_instance.primary.id
  instance_class          = "db.t3.micro"

  publicly_accessible     = false
  auto_minor_version_upgrade = true
  apply_immediately          = true
  backup_retention_period    = 0

  maintenance_window = "sun:03:00-sun:04:00"

  depends_on = [data.aws_db_instance.primary]
}
