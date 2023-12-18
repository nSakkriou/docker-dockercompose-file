output "loadbalancer_url"{
    value = aws_lb.lb.dns_name
}

output "lb_target_group_arn"{
    value = aws_lb_target_group.target-group-lb.arn
}