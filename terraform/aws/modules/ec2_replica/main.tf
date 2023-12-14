resource "aws_instance" "ec2" {
  count = length(var.instance_configs)

  ami           = "ami-06d4b7182ac3480fa"
  instance_type = "t2.micro"
  subnet_id     = var.instance_configs[count.index].subnet_id
  vpc_security_group_ids = [var.instance_configs[count.index].security_group]

  tags = {
    Name = var.instance_configs[count.index].name
  }
}