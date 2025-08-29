resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "db-subnet-group"
  subnet_ids = var.private_subnet_ids

  tags = {
    Name = "db-Subnet-Group"
  }
}

resource "aws_db_instance" "my_rds" {
    identifier             = var.identifier
    instance_class         = var.instance_class
    engine                 = var.engine
    engine_version         = var.engine_version
    allocated_storage      = var.storage

    db_name                = var.DB_NAME
    username               = var.DB_USERNAME
    password               = var.DB_PASSWORD
    
    multi_az               = var.multi_az
    skip_final_snapshot    = var.skip_final_snapshot
    db_subnet_group_name    = aws_db_subnet_group.db_subnet_group.name
    vpc_security_group_ids = [var.db_sg]
    
    tags = {
        Name = "my-rds"
    }
}