resource "aws_launch_configuration" "ec2_config" {
  name = "ec2-configuration"
  security_groups = [var.ec2_security_group_id]
  image_id = "ami-06d4b7182ac3480fa"
  instance_type = "t2.micro"
  user_data = templatefile("modules/ec2_replica/init_ec2.sh", 
  { 
    host_env = var.host_env
    dbname_env = var.dbname_env
    user_env = var.user_env
    password_env = var.password_env
  })
}

resource "aws_autoscaling_group" "ec2" {
  desired_capacity     = var.desired_instance
  max_size             = var.max_instance
  min_size             = var.min_instance

  vpc_zone_identifier = var.available_subnets

  launch_configuration = aws_launch_configuration.ec2_config.id
}

resource "aws_ec2_instance_connect_endpoint" "endpoint_autoscalling" {
  subnet_id = var.available_subnets[0]
}

resource "aws_autoscaling_attachment" "example" {
  autoscaling_group_name = aws_autoscaling_group.ec2.name
  lb_target_group_arn   = var.target_group_arn
}
