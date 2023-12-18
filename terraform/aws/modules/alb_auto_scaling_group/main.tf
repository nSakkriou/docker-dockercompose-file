resource "aws_lb" "lb" {
  name               = "loadbalancer"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.loadbalancer_security_group_id]
  subnets            = var.subnet_id_list
  
}

resource "aws_lb_target_group" "target-group-lb" {
  name     = "target-group-lb"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}

resource "aws_lb_listener" "lb" {
  load_balancer_arn = aws_lb.lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target-group-lb.arn
  }
}