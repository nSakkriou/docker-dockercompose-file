output "db_id" {
    value = aws_db_instance.sql_db.id
}

output "db_host" {
    value = aws_db_instance.sql_db.endpoint
}