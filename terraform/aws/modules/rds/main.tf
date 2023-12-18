resource "aws_db_instance" "sql_db" {
  allocated_storage    = 20
  db_name              = var.db_name
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  username             = var.db_user
  password             = var.db_password
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true
  multi_az = false
  db_subnet_group_name = aws_db_subnet_group.dbSubnetGroup.name
  vpc_security_group_ids = [var.security_group_db_id]
  tags = {
    Name = "sql-db"
  }
}

resource "aws_db_subnet_group" "dbSubnetGroup" {
  name       = "main_subnet_group"
  subnet_ids = var.subnet_id_list

  tags = {
    Name = "db-subnet"
  }
}