output length {
    value = length(var.instance_configs)
}

output instance_id {
    value = aws_instance.ec2[*].id
}