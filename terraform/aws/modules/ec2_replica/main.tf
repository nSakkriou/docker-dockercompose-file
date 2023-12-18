resource "aws_instance" "ec2" {
  count = length(var.instance_configs)

  ami           = "ami-06d4b7182ac3480fa"
  instance_type = "t2.micro"
  subnet_id     = var.instance_configs[count.index].subnet_id
  vpc_security_group_ids = [var.instance_configs[count.index].security_group]
  
  user_data = templatefile("modules/ec2_replica/init_ec2.sh", 
  { 
    host_env = var.host_env
    dbname_env = var.dbname_env
    user_env = var.user_env
    password_env = var.password_env
  })

  tags = {
    Name = var.instance_configs[count.index].name
  }
}

resource "aws_ec2_instance_connect_endpoint" "endpoint" {
  subnet_id = var.instance_configs[0].subnet_id
}