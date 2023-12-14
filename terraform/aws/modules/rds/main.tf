resource "aws_db_instance" "db" {
    identifier           = var.name
    allocated_storage    = 20
    storage_type         = "gp2"
    engine               = "mysql"
    instance_class       = "db.t2.micro"
    username             = var.username
    password             = var.password
    publicly_accessible  = false
    multi_az             = false

    tags = {
    Name = var.name
    }
}